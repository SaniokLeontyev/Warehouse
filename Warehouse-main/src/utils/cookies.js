import Cookies from 'js-cookie'

export const setCookie = (key, value, params) => {
    Cookies.set(key, value, params)
}
export const getCookie = (key) => Cookies.get(key)
export const removeCookie = (key) => Cookies.remove(key)