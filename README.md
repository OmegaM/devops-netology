# README #

This project is about learning [DevOps](https://netology.ru/programs/devops)

## ABOUT .gitignore files

This project has several .gitignore files 

### 1. Root .gitignore

### 2.Terraform directory .gitignore 
Exclude:

- [X] Local terraform directories
- [X] .tfstate files
- [X] crash logs
- [X] override.tf (Use to override  resources locally)
- [X] .terraformrc (CLI config files)



#### Lesson 2.4
 
#### 1. git checkout aefea

 Commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545 (HEAD)
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.m

#### 2. git show 85024d3

commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)

#### 3. git show b8d720 --pretty=%P

56cd7859e05c36c06b56d013b55a252d0bb7e158
9ea88f22fc6269854151c571162c5bcf958bee2b


#### 4. git log --pretty=%H v0.12.23...v0.12.24

33ff1c03bb960b332be3af2e333462dde88b279e
b14b74c4939dcab573326f4e3ee2a62e23e12f89
3f235065b9347a758efadc92295b540ee0a5e26e
6ae64e247b332925b872447e9ce869657281c2bf
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353
06275647e2b53d97d4f0a19a0fec11f6d69820b5
d5f9411f5108260320064349b757f55c09bc4b80
4b6d06cc5dcb78af637bbb19c198faff37a066ed
dd01a35078f040ca984cdd349f18d0b67e486c35
225466bc3e5f35baa5d07197bbc079345b77525e

#### 5. git log -S 'func providerSource'

commit 5af1e6234ab6da412fb8637393c5a17a1b293663
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Tue Apr 21 16:28:59 2020 -0700

    main: Honor explicit provider_installation CLI config when present
    
    If the CLI configuration contains a provider_installation block then we'll
    use the source configuration it describes instead of the implied one we'd
    build otherwise.

commit 8c928e83589d90a031f811fae52a81be7153e82f
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Apr 2 18:04:39 2020 -0700

    main: Consult local directories as potential mirrors of providers
    
    This restores some of the local search directories we used to include when
    searching for provider plugins in Terraform 0.12 and earlier. The
    directory structures we are expecting in these are different than before,
    so existing directory contents will not be compatible without
    restructuring, but we need to retain support for these local directories
    so that users can continue to sideload third-party provider plugins until
    the explicit, first-class provider mirrors configuration (in CLI config)
    is implemented, at which point users will be able to override these to
    whatever directories they want.
    
    This also includes some new search directories that are specific to the
    operating system where Terraform is running, following the documented
    layout conventions of that platform. In particular, this follows the
    XDG Base Directory specification on Unix systems, which has been a
    somewhat-common request to better support "sideloading" of packages via
    standard Linux distribution package managers and other similar mechanisms.
    While it isn't strictly necessary to add that now, it seems ideal to do
    all of the changes to our search directory layout at once so that our
    documentation about this can cleanly distinguish "0.12 and earlier" vs.
    "0.13 and later", rather than having to document a complex sequence of
    smaller changes.
    
    Because this behavior is a result of the integration of package main with
    package command, this behavior is verified using an e2etest rather than
    a unit test. That test, TestInitProvidersVendored, is also fixed here to
    create a suitable directory structure for the platform where the test is
    being run. This fixes TestInitProvidersVendored.

#### 6. git log -S globalPluginDirs

commit 35a058fb3ddfae9cfee0b3893822c9a95b920f4c
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Oct 19 17:40:20 2017 -0700

    main: configure credentials from the CLI config file

commit c0b17610965450a89598da491ce9b6b5cbd6393f
Author: James Bardin <j.bardin@gmail.com>
Date:   Mon Jun 12 15:04:40 2017 -0400

    prevent log output during init
    
    The extra output shouldn't be seen by the user, and is causing TFE to
    fail.

commit 8364383c359a6b738a436d1b7745ccdce178df47
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Apr 13 18:05:58 2017 -0700

    Push plugin discovery down into command package
    
    Previously we did plugin discovery in the main package, but as we move
    towards versioned plugins we need more information available in order to
    resolve plugins, so we move this responsibility into the command package
    itself.
    
    For the moment this is just preserving the existing behavior as long as
    there are only internal and unversioned plugins present. This is the
    final state for provisioners in 0.10, since we don't want to support
    versioned provisioners yet. For providers this is just a checkpoint along
    the way, since further work is required to apply version constraints from
    configuration and support additional plugin search directories.
    
    The automatic plugin discovery behavior is not desirable for tests because
    we want to mock the plugins there, so we add a new backdoor for the tests
    to use to skip the plugin discovery and just provide their own mock
    implementations. Most of this diff is thus noisy rework of the tests to
    use this new mechanism.
 
#### 7. git log -S synchronizedWriters --pretty=%an

Martin Atkins
