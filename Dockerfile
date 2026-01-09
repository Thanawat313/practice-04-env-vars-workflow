test-and-build:
    runs-on: ubuntu-latest
    steps:
      - name: Get Code
        uses: actions/checkout@v4
      
      # This builds the image using the Dockerfile in your folder
      - name: Build Docker Image
        run: docker build -t my-app-image:latest . 
        
      # You can then run your tests inside that newly built image
      - name: Run Tests in Docker
        run: |
          docker run -d -p 8080:8080 \
            -e MONGODB_USERNAME=${{ secrets.MONGODB_USERNAME }} \
            -e MONGODB_PASSWORD=${{ secrets.MONGODB_PASSWORD }} \
            --name test-container my-app-image:latest
          docker exec test-container npm test