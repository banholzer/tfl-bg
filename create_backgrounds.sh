#!/bin/bash

# Save the current working directory
cwd=$(pwd)

# Change working directory to /var/www/html/
cd /var/www/html/

# Create img and thumbs directories if they don't exist
mkdir -p img thumbs

# Loop through all .jpg files in the source directory
for file in ./source/*.jpg; do
    # Get the filename without extension
    filename=$(basename "$file" .jpg)

    # Create scaled image with 1920x1080 pixels
    convert "$file" -resize 1920x1080^ -gravity center -extent 1920x1080 "img/$filename.jpg"

    # Create scaled image with 280x158 pixels
    convert "$file" -resize 280x158^ -gravity center -extent 280x158 "thumbs/$filename.jpg"

    # Add image information to config.json
    echo '{
        "filetype": "jpg",
        "id": "'"$filename"'",
        "name": "'"$filename"'",
        "src": "/img/'"$filename"'.jpg",
        "thumb_src": "/thumbs/'"$filename"'.jpg"
    },' >> config.json
done

# Remove the last comma from config.json
sed -i '$ s/,$//' config.json

# Add opening and closing brackets to config.json
sed -i '1s/^/[/' config.json
echo ']' >> config.json

# Change working directory back to the original directory
cd ${cwd}
