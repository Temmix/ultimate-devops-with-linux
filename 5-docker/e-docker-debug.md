DOCKER DEBUG

Show the logs for a container, in case of any error
    - docker logs containerID

Get access into the container like any other linux sytem
    - docker exec -it containerID /bin/bash

Check the environment variable inside the container, after above step
    - env  
