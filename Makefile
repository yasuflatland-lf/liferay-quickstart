# Cleanup database
clean:
	cd ./db; \
	rm -fR mysql_data;

# Destroy all environment
destory:
	cd ./db; \
	rm -fR mysql_data; \
	cd ../; \
	docker-compose down --rmi all --volumes --remove-orphans; \
	docker-compose -f docker-compose-ce.yml down --rmi all --volumes --remove-orphans; \
	docker-compose -f docker-compose-commerce.yml down --rmi all --volumes --remove-orphans;

# Shorthand of running docker images
run:
	docker-compose up --build;