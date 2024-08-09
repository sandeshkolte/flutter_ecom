import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';

const DashBoard = () => {
    const baseUrl = "http://192.168.1.4:3000/products/";

    const [products, setProduct] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    const [error, setError] = useState(null);

const deleteItem = async(id) =>{
    try{
const {data} = await axios.get(`${baseUrl}delete/?id=${id}`)
    }catch(err){
        if (axios.isCancel(error)) {
            console.log("Fetch aborted");
            return;
        }
    }
}

    useEffect(() => {
        const fetchProducts = async () => {
            try {
                const { data } = await axios.get(baseUrl); // Fetch data based on the current page
                setProduct(data.response); // Set the fetched data
                console.log(data.response);

                setError(null); // Clear any previous errors
            } catch (error) {
                if (axios.isCancel(error)) {
                    console.log("Fetch aborted"); // Log a message when the request is intentionally aborted
                    return; // Exit the function to prevent further error handling
                }
                setError(error.message); // Handle and set the error message
            } finally {
                setIsLoading(false); // Turn off loading indicator
            }
        }
        fetchProducts();

    
        return () => {
            setIsLoading(true);
        }
    }, []);

    return (
        <div className='bg-[#f4f4f6] w-full p-10 h-screen'>
            <section>
                <div className='flex justify-between align-middle h-16 w-full'>
                    <h1 className='text-2xl font-bold'>DashBoard</h1>
                    <div className='outline-black outline-4'>
                        <img className='h-12 rounded-3xl object-cover' src="https://i.pinimg.com/originals/7d/ff/55/7dff551f2d67f821295ee46d87cdf709.jpg" alt="profile" />
                    </div>
                </div>
            </section>
            <br />
            <section className='bg-white w-full px-10 py-6 h-full rounded-3xl'>
                <div className='flex justify-between py-5'>
                    <h1 className='font-bold text-xl'>Products</h1>
                    <div className='bg-violet-50 px-2 py-1 rounded-lg'>
                        <i className="ri-search-line text-gray-400"></i>
                        <input type="text" placeholder='search' className='bg-violet-50 px-2 rounded-lg w-28 outline-none' />
                    </div>
                </div>

                <div className='bg-gray-200 w-full h-[2px]'></div>
                <div className='grid grid-cols-8 py-5'>
                    <h1>Image</h1>
                    <h1>Name</h1>
                    <h1>Brand</h1>
                    <h1>Price</h1>
                    <h1>Discount</h1>
                    <h1>Stock</h1>
                    <h1>Category</h1>
                    <h1>Edits</h1>
                </div>
                <div className='bg-gray-200 w-full h-[2px]'></div>
                <br />
                
                <div className='max-h-96 overflow-auto'>
                    {error && <div className='flex justify-center align-middle text-center' >
                        <h1 className='text-gray-400 text-center text-xl'>{error}</h1>
                        </div>}
                    {isLoading && <div> <h1 className='text-gray-400 text-center text-xl'>Loading...</h1></div>}
                    <div className="grid grid-cols-8 gap-4">
                        {products.map((product) => (
                            <React.Fragment key={product._id}>
                                <div className="col-span-1 h-28 w-28 rounded-lg bg-gray-100">
                                    <img src={product.image} alt="product" className="object-cover w-full h-full" />
                                </div>
                                <h3 className="col-span-1">{product.name}</h3>
                                <h3 className="col-span-1">{product.seller}</h3>
                                <h3 className="col-span-1">{product.price}</h3>
                                <h3 className="col-span-1">{product.discount}</h3>
                                <h3 className="col-span-1">{product.stock}</h3>
                                <h3 className="col-span-1">{product.category}</h3>
                                <div className="col-span-1 flex flex-col space-y-2">
                                    <Link className="rounded-lg text-center py-1" to={`/update/${product._id}`}><i className="ri-edit-box-line px-2 py-1 bg-gray-100 rounded-lg"></i></Link>
                                    <button className="rounded-lg text-center py-1" onClick={(e) =>deleteItem(product._id)} ><i className="ri-delete-bin-6-line bg-gray-100 rounded-lg"></i></button>
                                </div>
                            </React.Fragment>
                        ))}
                    </div>
                </div>
            </section>
        </div>
    )
}

export default DashBoard;
