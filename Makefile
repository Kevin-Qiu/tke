build:
	docker build -f deployments/Dockerfile -t tke-study/app:v1.0.0   --target=app .
	docker build -f deployments/Dockerfile -t tke-study/nginx:v1.0.0 --target=nginx .

push:
	docker login 37-test-tke.tencentcloudcr.com --username 100022318018 --password eyJhbGciOiJSUzI1NiIsImtpZCI6IllTRVQ6QUQ2NjpUQU9MOjVESks6RjROUTozUEs2OkJHSVI6NlFKSzpOUFIyOlFVVUo6UlEyUjo1TkFCIn0.eyJvd25lclVpbiI6IjY2NjE5ODIiLCJvcGVyYXRvclVpbiI6IjEwMDAyMjMxODAxOCIsInRva2VuSWQiOiJjNjlrdDBoMXFjbDN0YmM5ZzdzMCIsImV4cCI6MTk1MjQwMzg0MiwibmJmIjoxNjM3MDQzODQyLCJpYXQiOjE2MzcwNDM4NDJ9.bsdCjSbmyR9OX9NS48yKuaKUUFo0ql6wcl7jQ8382fAoGZ5eNiRDGJwHYtjJ1MKhlb7OGylGPXJNWagTpm9g-NmvXnbbZJDr3K0z8pD3LnuC63arJmZobyGnG7-mvCaIHOsZ4Tcj5_eVtDjSYxCyyQeM56d1L5992in2nVNLKBAGno0vXxumKUiiiboMZVblQFO8mH2ky1AY_4p-qMskI7dr2W6B5nzEnhkjnXTIFZXgn81cqm44iwb-Tb3erBLxx6bkcL7qKXYEARdXFjb6ZJiyzlPwx66EQFPwxP5EKlLag5b_XVwIZn4t-1_6BdPj2OwvN6azB0HmmBs0BtoyZw
	docker push 37-test-tke.tencentcloudcr.com/tke-study/app:v1.0.0
	docker push 37-test-tke.tencentcloudcr.com/tke-study/nginx:v1.0.0

deploy:
	kubectl apply -f deployments/deploy.yml