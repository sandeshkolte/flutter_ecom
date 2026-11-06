import { createContext, useContext, useEffect, useState } from 'react';
import { api, backendUrl } from '../common';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  const [owner, setOwner] = useState(null);
  const [isCheckingSession, setIsCheckingSession] = useState(true);

  useEffect(() => {
    let isCurrent = true;

    api.get(`${backendUrl}owner/me`)
      .then(({ data }) => {
        if (isCurrent) setOwner(data.response);
      })
      .catch(() => {
        if (isCurrent) setOwner(null);
      })
      .finally(() => {
        if (isCurrent) setIsCheckingSession(false);
      });

    return () => {
      isCurrent = false;
    };
  }, []);

  return (
    <AuthContext.Provider value={{ owner, setOwner, isCheckingSession }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider.');
  }
  return context;
};
