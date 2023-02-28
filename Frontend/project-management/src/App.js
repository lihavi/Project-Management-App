import React from "react";
import {BrowserRouter, Route} from "react-router-dom";
import Navbar from "./components/Navbar";

const App = () => {
  return (
    <BrowserRouter>
      <div>
        <Navbar/>
        <Route exact path="/" component={Home}/>
        <Route path="/projects" component={Projects}/>
      </div>
    </BrowserRouter>
  );
}

const Home = () => {
  return(
    <div>
      <h1>Welcome to Project Management App!</h1>

    </div>
  )
}

const Projects = () => {
  return (
    <div>
      <h1>Projects Page</h1>
    </div>
  );
};

export default App;