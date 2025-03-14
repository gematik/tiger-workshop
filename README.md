# tiger-workshop

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
       <ul>
        <li><a href="#release-notes">Release Notes</a></li>
      </ul>
	</li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## About The Project
This project is used for the tiger-workshop. It contains several branches. The branches

```code
workshop/stage1
...
workshop/stage9
```
correspond to the exercise names in the TigerWorkshop.pdf in the root directory.
The exercises build on each other. If the user did not do the previous exercise,
he/she can jump to the current exercise by checking out the corresponding branch.
For the exercise "Stage1" the user should check out the `workshop/stage1`, for the exercise "Stage2" the branch `workshop/stage2` and so on.

The following branches are used to show certain features of tiger.

`workshop/zion`:
This branch shows a simple example of the zero-line mock server.

`workshop/rbelbuilder`:
Tiger supports modifying JSON, XML and several token formats. After loading in an object from a string or a file the RbelObject can be modified 
by changing/adding/replacing primitive values. This branch shows how to use the RbelBuilder to modify a JSON object.

`workshop/screenplay`:
This branch shows a simple example of how the tiger can be used to use the screenplay pattern for writing tests.


### Release Notes
See [ReleaseNotes.md](./ReleaseNotes.md) for all information regarding the (newest) releases.

## Getting Started
See the TigerWorkshop.pdf for a detailed description of the exercises and how to use the branches.
