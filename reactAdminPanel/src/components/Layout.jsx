import React from 'react'
import Aside from './Aside'
import { Outlet } from 'react-router-dom'

const Layout = () => {
  return (<>
  <div className='flex overflow-hidden h-screen'>
  <Aside/>
  <Outlet/>
  </div>
  </>
  )
}

export default Layout