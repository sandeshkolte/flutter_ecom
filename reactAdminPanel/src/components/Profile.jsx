import React from 'react'
import {Link} from 'react-router-dom'

const Profile = () => {
  return (
    
    <div className='bg-zinc-900 h-screen w-full'>
      <h1 className='text-sky-500 text-sm'>Profile</h1>
      <Link to='/' className='text-yellow-400'>Change to Home</Link>
    </div>
  )
}

export default Profile