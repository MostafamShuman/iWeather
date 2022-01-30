<br />
<p align="center">
    <img src="README Files/metaweather.png" alt="Logo" width="100" height="100">

  <h3 align="center">iOS Metaweather  App</h3>

  <p align="center">
    Sample Live weather iOS app <br>based on weather data from Metaweather
    <br />
   
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li> <a href="#environment">Environment</a></li>
    <li> <a href="#wireframe">Wireframe</a></li>
    <li><a href="#snapshots">Snapshots</a></li>
    <li><a href="#project-structure">Project Structure</a></li>
    <li><a href="#code-structure">Code Structure</a></li>
    <li><a href="#structure-digram">Structure Digram</a></li>
  </ol>
</details>

<!-- Environment -->

## Environment
<ul> 
<li> <B>macOS Monterey v-12.1</B></li>
<li> <B>Developed using Xcode 13.2.1</B></li> 
<li> <B>Git Flow</B></li>
<li> <B>Supported Devices</B>: iPhone.
<li> <B>Minimum Deployment Target</B>: iOS 13:0+
<li> <B>Device Orientation</B>: Portrait.
</ul>

<!-- Wireframe -->
## Wireframe
<br>
<p float="left">
  <img src="README Files/wireframe.png" width="800" />
</p>
<br>
<br>
<!-- Snapshot -->

## Snapshots
<br>
<p float="left">
  <img src="README Files/scr_sht_0.png" width="180" />&nbsp;&nbsp;
  <img src="README Files/scr_sht_2.png" width="180" />&nbsp;&nbsp;
  <img src="README Files/scr_sht_3.png" width="180" />&nbsp;&nbsp;
  <img src="README Files/scr_sht_4.png" width="180" />
</p>
<br>
<br>

## Project Structure
Our app is divided into Three Component (Core - Business Logic - Presentation)
<ul>
<li><B>Core Layer:</B> Contains lower-level features and modules that are necessary for the business logic to function but don't depend on the business of the app.</li>
<li> <B>Business Logic:</B> that contains...
<ul>
<li><B>Data Layer:</B>  Has entities, datasources and repositories. </li>
<li><B>Domain Layer:</B> Contains use cases that are used by the presentation layer, in our case, it's consumed by the ViewModel.</li>
<li><B>Support Files:</B> Contains helper files, extensions, resources and localization files</li>
</ul>
</lis>
<li><B>Presentation Layer:</B> Consists of all UI logic and structures, it basically depends on the domain layer to fetch data and updated it to be consumable and rendered by the view</li>
<li><B>Factory:</B> Contains creational design pattern which solves the problem of creating product objects without specifying their concrete classes. </li>
</ul>
<br>
<br>

 ## Code Structure

 The apllication is built using MVVM design pattern that consists of three layers (Model - View - ViewModel):
 <ul>
 <li><B>View: </B>Anything that is a UIView subclass. It should be reusable and as passive as possible</li>
 <li><B>ViewController: </B>An object that is created to manage the behavior of a specific view. May act as a data source or event handler.</li>
 <li><B>ViewModel: </B>Receives a task’s result from the use case and transforms it into a view-suitable format.</li>
 <li><B>Model: </B>A plain object, such as a Codable model or a Core Data entity.</li>
 <li><B>Use case: </B>Performs business logic in the app, but is not aware of lower-level implementations, such as network clients or databases. For this, we have dependencies on repositoroes of services that do know about them and use them directly. When a service’s task is performed, the use case obtains the result and sends it to the ViewModel.</li>
 <li><B>Factory: </B>An object that creates a module by linking all the previous components.</li>
 </ul>
<br>
<br>

## Structure Digram
<p float="left">
  <center> <img src="README Files/digram.png" width="600" /> </center>
</p>
