# Liferay DXP / CE / Commerce Quick Start with MySQL
This is quick start for Liferay DXP instance by docker-compose and MySQL server with utf8mb4, Japanese conscious character set configuration.

# Precondition 
- Docker installed
- Docker compose installed
- Liferay DXP Trial license
- Intel Core i7 equivalent CPU with 16GB or more memories.
  
# Quickstart
1. Clone this repo
2. Place reqired files
   - For DXP, please place a Liferay DXP license file at `./liferay/deploy`. 
   - For Commerce, please place commerce licence at `./liferay/deploy`. 
   - You may also need to download Commerce Demo Pack from [help.liferay.com](https://customer.liferay.com/en/downloads?p_p_id=com_liferay_osb_customer_downloads_display_web_DownloadsDisplayPortlet&_com_liferay_osb_customer_downloads_display_web_DownloadsDisplayPortlet_productAssetCategoryId=118190997&_com_liferay_osb_customer_downloads_display_web_DownloadsDisplayPortlet_fileTypeAssetCategoryId=118191001) for Demo purpose. Please place this file at `./liferay/deploy`. For this version(`commerce-enterprise:2.1.2-7.2.x`), please download `Liferay Commerce Demo Pack 2.1.2`.
3. Run Liferay
   
   **For DXP**
   ```
   docker-compose up --build
   ```

   **For CE**
   ```
   docker-compose -f docker-compose-ce.yml up --build
   ```

   **For Commerce**
   ```
   docker-compose -f docker-compose-commerce.yml up --build
   ```

# How to set up the default tables
Please see `db/mysql_init/01-databases.sql` and add tables accordingly. 

# How to cleanup the environment.
1. Delete `db/mysql_data`
2. Delete environment
   
   **For DXP**
   ```
   docker-compose down --rmi all --volumes --remove-orphans
   ```
   
   **For CE**
   ```
   docker-compose -f docker-compose-ce.yml down --rmi all --volumes --remove-orphans
   ```

   **For Commerce**
   ```
   docker-compose -f docker-compose-commerce.yml down --rmi all --volumes --remove-orphans
   ```

# How to customize Liferay files
See `./liferay/files` folder. This is the root folder of Liferay in the container.

| Directory | Note |
| :-- | :-- |
| `./liferay/deploy` | Place licence file and bundles to deploy here |
| `./liferay/files/` | Root directory of the Liferay bundle |
| `./liferay/files/tomcat` | This is equivalent of tomcat folder |

# Operation Tips

## utf8mb4 Configuration
Check if the tables are created as utf8mb4. Client also need to be switched to utf8mb4 to display data correctly. 

    In the case of Sequel Pro, Navigate to `Database -> Display with a specific Encode` and chose `utf8mb4` in the menu.

## JDBC Configuration
In the `docker-compose.yml`, It's all configured by default. Please configure accordingly in case you need to change the setting from the default.
   
   For DXP 7.3, it's as follows.
   ```
    - LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_DRIVER_UPPERCASEC_LASS_UPPERCASEN_AME=com.mysql.cj.jdbc.Driver
    - LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_USERNAME=root
    - LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_PASSWORD=password
    - LIFERAY_JDBC_PERIOD_DEFAULT_PERIOD_URL=jdbc:mysql://mysql/lrportal?connectionCollation=utf8mb4_bin&dontTrackOpenResources=true&holdResultsOpenOverStatementClose=true&serverTimezone=GMT&useFastDateParsing=false&useUnicode=true&characterEncoding=utf8
   ```

# Appendix
## characterEncoding setting
As [the official document](https://dev.mysql.com/doc/connector-j/8.0/en/connector-j-reference-charsets.html) shows, 
```
For 8.0.12 and earlier: utf8
For 8.0.13 and later: utf8mb4
```
Please be careful in case you need to switch the MySQL image higher than Ver 8.