const cloudinary = require('cloudinary').v2;

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

const uploadProductImage = async (req, res) => {
  if (!req.file) {
    return res.status(400).json({ status: 'Error', response: 'An image file is required.' });
  }

  if (
    !process.env.CLOUDINARY_CLOUD_NAME ||
    !process.env.CLOUDINARY_API_KEY ||
    !process.env.CLOUDINARY_API_SECRET
  ) {
    return res.status(500).json({
      status: 'Error',
      response:
        'Cloudinary is not configured on the server. Set CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, and CLOUDINARY_API_SECRET in the backend deployment environment, then redeploy.',
    });
  }

  try {
    const result = await new Promise((resolve, reject) => {
      const stream = cloudinary.uploader.upload_stream(
        {
          folder: process.env.CLOUDINARY_FOLDER || 'flutter_ecom/products',
          resource_type: 'image',
        },
        (error, uploadedImage) => {
          if (error) {
            reject(error);
            return;
          }
          resolve(uploadedImage);
        },
      );
      stream.end(req.file.buffer);
    });

    return res.status(201).json({ status: 'success', url: result.secure_url });
  } catch (error) {
    console.error('Cloudinary image upload failed:', error);
    return res.status(502).json({ status: 'Error', response: 'Image upload failed.' });
  }
};

module.exports = { uploadProductImage };
