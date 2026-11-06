import axios from 'axios';

// export const baseUrl= "https://flutter-ecom.onrender.com/products/"
export const baseUrl = import.meta.env.VITE_BASE_URL;
export const backendUrl = (import.meta.env.VITE_BACKEND_URL || baseUrl.replace(/products\/?$/, '')).replace(/\/?$/, '/');
export const api = axios.create({ withCredentials: true });

export const uploadProductImage = async (file, onUploadProgress) => {
  const formData = new FormData();
  formData.append('image', file);

  const { data } = await api.post(`${baseUrl}upload-image`, formData, {
    onUploadProgress,
  });

  if (typeof data.url !== 'string' || !data.url) {
    throw new Error('Image upload did not return a Cloudinary URL.');
  }

  return data.url;
};