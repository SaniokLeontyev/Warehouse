import { BrowserRouter, Routes, Route } from "react-router-dom";
import Sidebar from "./modules/sidebar/Sidebar";
import PrivateRoute from "./modules/privateRoute";
import { ToastContainer } from "react-toastify";
import 'react-toastify/dist/ReactToastify.css';

import Auth from "./modules/auth/pages/Auth";
import UserLayout from './modules/users/LayoutUsers'
import ConstructorList from "./modules/constructor/pages/ConstructorLists";
import ConstructorCreate from './modules/constructor/pages/ConstructorCreate'
import StartPage from "./modules/start/pages/Start";
import AddUser from "./modules/users/pages/AddUser";
import ConstructorEdit from "./modules/constructor/pages/ContstructorEdit";
import Docs from "./modules/docs/pages/Docs";
import Task from "./modules/tasks/pages/Taks";
import Invent from "./modules/audit/pages/Invent";
import Managment from "./modules/warehouse-managment/page/Managment";
import { Blocks } from "react-loader-spinner";
import { useSelector } from "react-redux";
import MyTask from "./modules/myTask/page/MyTask";
import EditUser from "./modules/users/pages/EditUser";

function App() {
    let loaderState = useSelector(state => state.loader)

    return (
        <div className='app-layer'>
            <div className={ loaderState ? "app-loader" : "app-loader__hide" }>
            <Blocks
                visible={loaderState}
                height="200"
                width="200"
                ariaLabel="blocks-loading"
                wrapperStyle={{}}
                wrapperClass="blocks-wrapper"
                />
            </div>
            <BrowserRouter>
                <ToastContainer 
                    position="top-right"
                    autoClose={5000}
                    hideProgressBar={false}
                    newestOnTop
                    closeOnClick={false}
                    rtl={false}
                    pauseOnFocusLoss
                    draggable={false}
                    pauseOnHover
                    theme="light"
                />
                <Sidebar></Sidebar>
                <Routes>
                    <Route path="/" element={
                        <PrivateRoute>
                            <StartPage />
                        </PrivateRoute>
                    } index></Route>
                    <Route path="/login" element={<Auth/>}/>
                    <Route path="/users" element={
                        <PrivateRoute>
                            <UserLayout/>
                        </PrivateRoute>
                    }/>
                    <Route path="/add-user" element={
                        <PrivateRoute>
                            <AddUser />
                        </PrivateRoute>
                    }/>
                    <Route path="/edit-user/:id" element={
                        <PrivateRoute>
                            <EditUser />
                        </PrivateRoute>
                    }/>
                    <Route path="/constructor" element={
                        <PrivateRoute>
                            <ConstructorList/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/constructor-create" element={
                        <PrivateRoute>
                            <ConstructorCreate/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/constructor-edit" element={
                        <PrivateRoute>
                            <ConstructorEdit/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/docs" element={
                        <PrivateRoute>
                            <Docs/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/task" element={
                        <PrivateRoute>
                            <Task/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/invent" element={
                        <PrivateRoute>
                            <Invent/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/managment" element={
                        <PrivateRoute>
                            <Managment/>
                        </PrivateRoute>
                    }></Route>
                    <Route path="/my-task" element={
                        <PrivateRoute>
                            <MyTask/>
                        </PrivateRoute>
                    }></Route>
                </Routes>
            </BrowserRouter>
        </div>
    )
}

export default App