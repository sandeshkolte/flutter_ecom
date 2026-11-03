# Backend setup

## Cloudinary image uploads

Set `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET`
in the backend environment. Set `CLOUDINARY_FOLDER` to the project's Cloudinary
folder; it defaults to `flutter_ecom/products` to keep these images separate
from other projects using the same Cloudinary account. `.env.example` lists the
variable names. Keep the API secret on the server; neither client should
contain Cloudinary credentials.

The admin panel and Flutter app upload multipart image files to
`POST /products/upload-image`. The endpoint accepts JPEG, PNG, WEBP, and GIF
images up to 10 MB and responds with the Cloudinary `url` to save on the
product.
