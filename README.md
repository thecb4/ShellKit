# ShellKit

[![pipeline status](https://gitlab.com/thecb4/shellkit/badges/master/pipeline.svg)](https://gitlab.com/thecb4/shellkit/-/commits/master)
![supported platforms](https://img.shields.io/badge/platform-macOS%20%7C%20linux-blue)
![macOS version](https://img.shields.io/badge/macOS-%3E%3D%2010.13-blue)

ShellKit gives you a powerful way to interface to the command line with a set of standard command or you can extend to create your own.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Built With

From scratch... like biscuits

### Prerequisites

* macOS 10.13 or later

```
@available(macOS 10.13, *)
```

### Installing

Package Manager

```
dependencies: [
  .package(url: "https://gitlab.com/thecb4/shellkit.git", .branch("master")),
],
```

## Using

ShellKit is used by importing the library and easily leveraging the existing commands

```
import ShellKit

try Shell.swiftTestGenerateLinuxMain()
```

### Testing

ShellKit does come with tests

```
swift test
```

## Roadmap and Contributing

### Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags).



### Roadmap

Please read [ROADMAP](ROADMAP.md) for an outline of how we would like to evolve the library.

### Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for changes to us.

### Changes

Please read [CHANGELOG](CHANGELOG.md) for details on changes to the library.


## Authors

* **'Cavelle Benjamin'** - *Initial work* - [thecb4](https://your-website.io)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
