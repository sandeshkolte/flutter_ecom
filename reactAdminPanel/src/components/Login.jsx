import { useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import { toast } from 'react-toastify';
import { api, backendUrl } from '../common';
import { useAuth } from '../auth/AuthContext';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const { setOwner } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();

  const handleSubmit = async (event) => {
    event.preventDefault();
    setIsSubmitting(true);

    try {
      const { data } = await api.post(`${backendUrl}owner/login`, { email, password });
      setOwner(data.response);
      navigate(location.state?.from?.pathname || '/', { replace: true });
    } catch (error) {
      toast.error(error.response?.data?.response || error.message || 'Login failed.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <main className="flex min-h-screen items-center justify-center bg-[#f4f4f6] p-5">
      <form onSubmit={handleSubmit} className="w-full max-w-md rounded-2xl bg-white p-8 shadow-xl">
        <h1 className="mb-2 text-2xl font-bold">Admin Login</h1>
        <p className="mb-6 text-gray-600">Sign in with your owner account to manage products.</p>
        <label className="mb-4 block">
          <span className="mb-1 block">Email</span>
          <input
            type="email"
            autoComplete="username"
            required
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            className="w-full rounded-lg bg-violet-50 px-4 py-3 outline-none focus:ring-2 focus:ring-violet-300"
          />
        </label>
        <label className="mb-6 block">
          <span className="mb-1 block">Password</span>
          <input
            type="password"
            autoComplete="current-password"
            required
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            className="w-full rounded-lg bg-violet-50 px-4 py-3 outline-none focus:ring-2 focus:ring-violet-300"
          />
        </label>
        <button
          type="submit"
          disabled={isSubmitting}
          className="w-full rounded-lg bg-violet-600 px-4 py-3 font-semibold text-white disabled:opacity-60"
        >
          {isSubmitting ? 'Signing in...' : 'Sign in'}
        </button>
      </form>
    </main>
  );
};

export default Login;
