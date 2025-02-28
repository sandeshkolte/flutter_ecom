import React, { useState } from 'react'
import { storage } from "../firebase"
import { ref, getDownloadURL, uploadBytes, uploadBytesResumable } from "firebase/storage"
import axios from 'axios'
import { useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { baseUrl } from '../common';


const CreateProduct = () => {
  const [progressPercent, setProgressPercent] = useState(0)
  const [formData, setformData] = useState({})
  const [imageUrl, setimageUrl] = useState("")


  const handleFileChange = (e) => {

    const file = e.target.files[0];

    if (file) {
      setimageUrl(file);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault()
    const file = imageUrl

    if (!file) return null;
    const storageRef = ref(storage, `files/${file.name}`)
    const uploadTask = uploadBytesResumable(storageRef, file)

    uploadTask.on("state_changed",
      (snapshot) => {
        const progress = Math.round((snapshot.bytesTransferred / snapshot.totalBytes) * 100)
        setProgressPercent(progress)
      },
      (error) => {
        alert(error)
      },
      () => {
        getDownloadURL(storageRef).then((downloadURL) => {
          console.log(downloadURL)
          setimageUrl(downloadURL)
          setformData((prevData) => ({
            ...prevData,
            image: downloadURL,
          }));
        })
      }
    )
  }

  const formChange = async (e) => {

    // e.formData.image  = imageUrl

    const { id, value } = e.target


    setformData({ ...formData, [id]: value })
  }


  const handleFormSubmit = async (e) => {
    e.preventDefault();

    console.log(JSON.stringify(formData))

    try {
      await axios.post(baseUrl + 'create', formData).then((response) => {
        console.log(`Form uploaded with data:`, response)
        toast.success("Product Created Successfully!")
        setformData({
          name: "",
          description: '',
          price: '',
          discount: '',
          stock: '',
          seller: '',
          category: '',
          image: ''
        });
        console.log(JSON.stringify(formData))
        setProgressPercent(0);
      })
    } catch (err) {
      if (axios.isCancel(err)) {
        console.log("Fetch aborted");
        return;
      }
    }
  }


  return (
    <div className='bg-[#f4f4f6] w-full p-10 h-screen flex flex-wrap'>
      <h1 className='text-2xl font-bold'>Create Product</h1>
      <form className='form' name='upload_file' onSubmit={handleFormSubmit}>
        <div className='image-section flex flex-col p-5 bg-white w-80 rounded-xl shadow-xl' >
          <input type="file" id='image' required onChange={handleFileChange} />
          <button type='submit' onClick={handleSubmit} className='w-32 my-5 py-2 bg-teal-200 rounded-lg shadow-xl' > {progressPercent == 100 ? "Uploaded " : "Upload Image"}</button>
          <progress value={progressPercent} className='h-1 rounded-xl' max="100" />
        </div>
        <div className="flex flex-wrap gap-3 p-5 my-5 bg-white w-full rounded-xl shadow-xl">
          <div>
            <h1>Name</h1>
            <input type="text" required placeholder="name" id="name" value={formData.name} onChange={formChange} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
          </div>
          <div>
            <h1 >Description</h1>
            <textarea type="text" required placeholder="description" value={formData.description} id="description" onChange={formChange} className="px-5 py-2 resize-none w-96 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none" />
          </div>
          <div>
            <h1>Price</h1>
            <input type="number" required placeholder="price" id="price" value={formData.price} onChange={formChange} className="px-5 py-2 max-w-28 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
          </div>
          <div>
            <h1 >Discount</h1>
            <input type="number" required placeholder="discount" id="discount" value={formData.discount} onChange={formChange} className="px-5 py-2 max-w-28 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
          </div>
          <div>
            <h1 >Stock</h1>
            <input type="number" required placeholder="stock" id="stock" value={formData.stock} onChange={formChange} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
          </div>
          <div>
            <h1 >Seller</h1>
            <input type="text" required placeholder="seller" id="seller" value={formData.seller} onChange={formChange} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
          </div>
          <div>
            <h1 >Category</h1>
            <input type="text" required placeholder="category" id="category" value={formData.category} onChange={formChange} className="px-5 py-2 bg-transparent shadow-xl rounded-lg bg-violet-200 outline-none " />
          </div>
        </div>
        <input className="m-5 bg-fuchsia-200 px-5 py-2 rounded-lg shadow-xl cursor-pointer" type="submit" value="Create Product" />
      </form>

    </div>
  )
}

export default CreateProduct