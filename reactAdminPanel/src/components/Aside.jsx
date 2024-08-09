import React from 'react'
import {Link, NavLink} from 'react-router-dom'

const Aside = () => {
  return (
    <>
    <div className='bg-white w-30'>
      <aside>
        <div className='p-5'>
          <img className='h-20 object-cover rounded-lg' src="src/assets/applogo.png" alt="logo" />
        
          <br />
          <ul className='flex flex-col gap-5'>
            <li>
            <NavLink to='/' className={({isActive})=>`
            font-semibold px-5 py-2 rounded-md w-full flex 
                ${isActive ? "bg-violet-50" : "bg-white"}
            `
            } ><i className="ri-dashboard-fill pr-2"></i>DashBoard</NavLink>
            </li>
            <li>
            <NavLink to='/profile' className={({isActive})=>`
            font-semibold px-5 py-2 rounded-md w-full flex 
                ${isActive ? "bg-violet-50" : "bg-white"}
            `
            } ><i className="ri-group-fill pr-2"></i>Profile</NavLink>
            </li>
            <li>
            <NavLink to='/createproduct' className={({isActive})=>`
            font-semibold px-5 py-2 rounded-md w-full flex 
                ${isActive ? "bg-violet-50" : "bg-white"}
            `
            } ><i className="ri-group-fill pr-2"></i>Create Product</NavLink>
            </li>
          
          </ul>
      {/* <h1 className='text-sky-500 text-sm'>Admin Panel</h1>
      <Link to='/profile' className='text-teal-300' >Change to Profile</Link> */}
        </div>
      </aside>
    </div>
    </>
  )
}

export default Aside