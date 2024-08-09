import './App.css'
import {Routes,Route} from 'react-router-dom'
import Profile from './components/Profile'
import DashBoard from './components/DashBoard'
import Layout from './components/Layout'
import CreateProduct from './components/CreateProduct'
import UpdateProduct from './components/UpdateProduct'

function App() {
  return (
    <>
    <div className=''>
    <Routes>
      <Route path='/' element={<Layout/>} >
      <Route path='' element={<DashBoard/>} />
      <Route path='profile' element={<Profile/>} />
      <Route path='createproduct' element={<CreateProduct/>} />
      <Route path='update/:id' element={<UpdateProduct/>} />
      </Route>
    </Routes>
    </div>
    </>
  )
}

export default App
