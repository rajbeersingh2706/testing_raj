 #!/bin/bash

           # Applying the New Image to Kubernetes
            if kubectl describe deployment/nginx-deployment; then
              echo "if Condition not exist"
            else
              echo "Does not Exits"
            fi
