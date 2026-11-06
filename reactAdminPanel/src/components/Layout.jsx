import React from 'react'
import Aside from './Aside'
import { Outlet } from 'react-router-dom'
import { api, backendUrl } from '../common'
import { useAuth } from '../auth/AuthContext'
import { toast } from 'react-toastify'

const Layout = () => {
  const { setOwner } = useAuth();

  const handleLogout = async () => {
    try {
      await api.post(`${backendUrl}owner/logout`);
      setOwner(null);
    } catch (error) {
      toast.error(error.response?.data?.response || error.message || 'Logout failed.');
    }
  };

  return (<>
  <div className='flex overflow-hidden h-screen'>
  <Aside onLogout={handleLogout}/>
  <Outlet/>
  </div>
  </>
  )
}

export default Layout