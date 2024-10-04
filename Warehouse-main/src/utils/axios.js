import axios from "axios";
import { clearUser } from "../modules/auth/store/actions";
import store from '../store/store'


export const baseURL = 'http://91.201.214.168:8082'
const axiosReq = axios.create({
  baseURL: baseURL,
  timeout: 30000,
  headers: {
    "Content-Type": "application/json",
    "Authorization": `Bearer ${store.getState().accessToken}`,
  },
});

axiosReq.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      removeCookie('access_token')
      // clearUser()
    }
    return Promise.reject(error);
  }
);

export default axiosReq;
