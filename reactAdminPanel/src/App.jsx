import './App.css'
import { Navigate, Route, Routes, useLocation } from 'react-router-dom'
import { AuthProvider, useAuth } from './auth/AuthContext'
import Profile from './components/Profile'
import DashBoard from './components/DashBoard'
import Layout from './components/Layout'
import CreateProduct from './components/CreateProduct'
import UpdateProduct from './components/UpdateProduct'
import Login from './components/Login'

const ProtectedLayout = () => {
  const { owner, isCheckingSession } = useAuth();
  const location = useLocation();

  if (isCheckingSession) {
    return <p className="p-8 text-center">Checking admin session...</p>;
  }

  if (!owner) {
    return <Navigate to="/login" replace state={{ from: location }} />;
  }

  return <Layout />;
};

function AppRoutes() {
  return (
    <div className=''>
    <Routes>
      <Route path='/login' element={<Login/>} />
      <Route path='/' element={<ProtectedLayout/>} >
      <Route path='' element={<DashBoard/>} />
      <Route path='profile' element={<Profile/>} />
      <Route path='createproduct' element={<CreateProduct/>} />
      <Route path='update/:id' element={<UpdateProduct/>} />
      </Route>
    </Routes>
    </div>
  )
}

function App() {
  return (
    <AuthProvider>
      <AppRoutes />
    </AuthProvider>
  );
}

export default App
