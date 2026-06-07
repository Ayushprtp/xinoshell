import jwt from 'jsonwebtoken';
import { JWT_EXPIRES_IN } from '@/lib/constants';

const JWT_SECRET = process.env.JWT_SECRET;

if (!JWT_SECRET) {
  throw new Error("JWT_SECRET environment variable is not set");
}

export const generateToken = (userId: string) => {

  try {
    const token = jwt.sign({ userId }, JWT_SECRET, {
      expiresIn: JWT_EXPIRES_IN,
    });
    return token;
  } catch (err) {
    throw err;
  }
};

export const verifyToken = (token: string) => {

  try {
    const payload = jwt.verify(token, JWT_SECRET) as { userId: string };
    return payload;
  } catch (error) {
    return null;
  }
};
