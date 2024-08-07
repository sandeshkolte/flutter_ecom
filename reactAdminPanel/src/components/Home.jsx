import React from 'react'
import {Link} from 'react-router-dom'

const Home = () => {
  return (
    <>
    <div className='bg-zinc-900 h-screen w-full'>
      <h1 className='text-sky-500 text-sm'>Home</h1>
      <Link to='/profile' className='text-teal-300' >Change to Profile</Link>
    </div>
    </>
  )
}

export default Home