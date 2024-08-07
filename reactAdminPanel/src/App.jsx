import { useState } from 'react'
import './App.css'
import {Routes,Route} from 'react-router-dom'
import Home from './components/Home'
import Profile from './components/Profile'

function App() {
  return (
    <>
    <div className='bg-zinc-900'>
    <Routes>
      <Route path='/' element={<Home/>} />
      <Route path='/profile' element={<Profile/>} />
    </Routes>
    </div>
    </>
  )
}

export default App
