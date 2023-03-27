NEXUS REST API

    QUERY REST API
curl -u user:pwd  -X GET 'http://46.101.4.116:8081/service/rest/v1/repositories'

You ll get the repositories based on the repositories user has right permissions on
    curl -u temi:13Seikos  -X GET 'http://46.101.4.116:8081/service/rest/v1/repositories'
    curl -u admin:13Seikos  -X GET 'http://46.101.4.116:8081/service/rest/v1/repositories'

You can also query components of a repository
    curl -u temi:13Seikos  -X GET 'http://46.101.4.116:8081/service/rest/v1/components?repository=maven-snapshots'

You can also query components of a repo by id which is unique per component
    curl -u admin:13Seikos  -X GET 'http://46.101.4.116:8081/service/rest/v1/components/bWF2ZW4tc25hcHNob3RzOjhhMTk4YjVjMGJjNjEzZGM1N2ZmOGFiOWQ0ZTM5NzQ3'

