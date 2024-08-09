import React, { useState } from 'react'
import {storage  } from "../firebase"
import { ref, getDownloadURL, uploadBytes, uploadBytesResumable } from "firebase/storage"
import axios from 'axios'

const baseUrl = "http://192.168.1.22:3000/products/create";


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

const formChange = async(e) =>{

    // e.formData.image  = imageUrl

    const {id,value} = e.target

    setformData({...formData,[id] : value})

}


const handleFormSubmit = async(e) =>{
    e.preventDefault();

    console.log(JSON.stringify(formData))
    try{
      await axios.post(baseUrl,formData).then((response)=>{
        console.log(`Form uploaded with data:`,response)
      })
    }catch(err) {
        if (axios.isCancel(err)) {
            console.log("Fetch aborted"); 
            return;    
        }
    }
}

  return (
    <div>
        <form className='form' name='upload_file' onSubmit={handleFormSubmit}>
            <input type="file" id='image' onChange={handleFileChange} />
            <button type='submit' onClick={handleSubmit}>Upload Image</button>
            <progress value={progressPercent} max="100"/>
            <div className="flex flex-wrap gap-3">
        <label htmlFor="name">Name</label>
        <input type="text" required placeholder="name" id="name" onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>
        <label htmlFor="desc">Description</label>
        <input type="text" required placeholder="description" id="description"onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>
        <label htmlFor="price">Price</label>
        <input type="number" required placeholder="price" id="price"onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>
        <label htmlFor="discount">Discount</label>
        <input type="number" required placeholder="discount" id="discount"onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>
        <label htmlFor="stock">Stock</label>
        <input type="number" required placeholder="stock" id="stock"onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>
        <label htmlFor="seller">Seller</label>
        <input type="text" required placeholder="seller" id="seller"onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>
        <label htmlFor="category">Category</label>
        <input type="text" required placeholder="category" id="category"onChange={formChange} className="px-5 py-2 bg-transparent border-2 border-zinc-800 rounded-lg outlined-none "/>    
    </div>
    <input className="m-5 bg-emerald-500 px-5 py-2 rounded-lg" type="submit" value="Create Product"/>
        </form>
    </div>
  )
}

export default CreateProduct