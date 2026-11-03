import React, { useEffect, useState } from 'react'
import axios from 'axios'
import { useLocation, useNavigate, useParams } from 'react-router-dom';
import { toast } from 'react-toastify';
import { baseUrl, uploadProductImage } from '../common';


const UpdateProduct = () => {
    const [progressPercent, setProgressPercent] = useState(0)
    const [formData, setformData] = useState({
        name: '',
        description: '',
        price: '',
        discount: '',
        stock: '',
        seller: '',
        category: '',
        image: '',
    })
    const [selectedFile, setSelectedFile] = useState(null)
    const [isUploading, setIsUploading] = useState(false)
    const [isLoading, setIsLoading] = useState(true)
    const [loadError, setLoadError] = useState('')

    const navigate = useNavigate()
    const location = useLocation()
    const { id } = useParams()

    const populateForm = (product) => {
        setformData({
            name: product.name ?? '',
            description: product.description ?? '',
            price: product.price ?? '',
            discount: product.discount ?? '',
            stock: product.stock ?? '',
            seller: product.seller ?? '',
            category: product.category ?? '',
            image: product.image ?? '',
        })
    }

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setSelectedFile(file);
            setProgressPercent(0);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault()
        if (!selectedFile) {
            toast.error('Choose an image before uploading.');
            return;
        }

        setIsUploading(true);
        try {
            const image = await uploadProductImage(selectedFile, (event) => {
                if (event.total) {
                    setProgressPercent(Math.round((event.loaded / event.total) * 100));
                }
            });
            setformData((prevData) => ({ ...prevData, image }));
            setProgressPercent(100);
            toast.success('Image uploaded successfully.');
        } catch (error) {
            toast.error(error.response?.data?.response || error.message || 'Image upload failed.');
        } finally {
            setIsUploading(false);
        }
    }

    const formChange = async (e) => {
        const { id, value } = e.target
        setformData({ ...formData, [id]: value })
    }


    const handleFormSubmit = async (e) => {
        e.preventDefault();
        if (isLoading || !formData.image) {
            toast.error('Upload a product image before saving the product.');
            return;
        }
        try {
            await axios.post(baseUrl+`update/${id}`, formData);
            toast.success("Product Updated Successfully!");
            navigate('/');
        } catch (err) {
            toast.error(err.response?.data?.response || err.message || 'Product update failed.');
        }
    }

    useEffect(() => {
        let isCurrent = true;
        const selectedProduct = location.state?.product;

        const fetchProduct = async () => {
            setIsLoading(true);
            setLoadError('');

            try {
                let product = selectedProduct?._id === id
                    ? selectedProduct
                    : null;

                if (!product) {
                    const { data } = await axios.get(baseUrl);
                    const products = data.response ?? data.products;
                    product = Array.isArray(products)
                        ? products.find((item) => item._id === id)
                        : null;
                }

                if (!product) {
                    throw new Error('Product was not found.');
                }

                if (isCurrent) {
                    populateForm(product);
                }
            } catch (error) {
                if (isCurrent) {
                    setLoadError(
                        error.response?.data?.response ||
                        error.message ||
                        'Unable to load product details.'
                    );
                }
            } finally {
                if (isCurrent) {
                    setIsLoading(false);
                }
            }
        };

        fetchProduct();

        return () => {
            isCurrent = false;
        };
    }, [id, location.state]);


    return (
        <div className='bg-[#f4f4f6] w-full p-10 h-screen flex flex-wrap'>
            <h1 className='text-2xl font-bold'>Update Product</h1>
            <form className='form' name='upload_file' onSubmit={handleFormSubmit}>
                <div className='image-section flex flex-col p-5 bg-white w-80 rounded-xl shadow-xl' >
                    {formData.image && (
                        <img src={formData.image} alt="Current product" className="mb-3 h-32 w-32 rounded-lg object-cover" />
                    )}
                    <input type="file" id='image' onChange={handleFileChange} />
                    <button type='button' onClick={handleSubmit} disabled={isUploading} className='w-32 my-5 py-2 bg-teal-200 rounded-lg shadow-xl' > {isUploading ? 'Uploading...' : progressPercent === 100 ? 'Uploaded' : 'Upload Image'}</button>
                    <progress value={progressPercent} className='h-1 rounded-xl' max="100" />
                </div>
                {isLoading && <p role="status">Loading product details...</p>}
                {loadError && <p role="alert" className="text-red-600">{loadError}</p>}
                <div className="flex flex-wrap gap-3 p-5 my-5 bg-white w-full rounded-xl shadow-xl">
                    <div>
                        <h1>Name</h1>
                        <input type="text" required placeholder="name" id="name" value={formData.name} onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
                    </div>
                    <div>
                        <h1 >Description</h1>
                        <textarea type="text" required placeholder="description" value={formData.description} id="description" onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 resize-none w-96 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none" />
                    </div>
                    <div>
                        <h1>Price</h1>
                        <input type="number" required placeholder="price" id="price" value={formData.price} onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 max-w-28 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
                    </div>
                    <div>
                        <h1 >Discount</h1>
                        <input type="number" required placeholder="discount" id="discount" value={formData.discount} onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 max-w-28 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
                    </div>
                    <div>
                        <h1 >Stock</h1>
                        <input type="number" required placeholder="stock" id="stock" value={formData.stock} onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
                    </div>
                    <div>
                        <h1 >Seller</h1>
                        <input type="text" required placeholder="seller" id="seller" value={formData.seller} onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
                    </div>
                    <div>
                        <h1 >Category</h1>
                        <input type="text" required placeholder="category" id="category" value={formData.category} onChange={formChange} disabled={isLoading || Boolean(loadError)} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
                    </div>
                </div>
                <input className="m-5 bg-fuchsia-200 px-5 py-2 rounded-lg shadow-xl cursor-pointer" type="submit" value="Update Product" disabled={isLoading || Boolean(loadError) || isUploading} />
            </form>

        </div>
    )
}

export default UpdateProduct