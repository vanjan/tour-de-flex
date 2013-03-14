Overview 
=========

Parsley has been selected to provide dependency injection.

Code has been separated into 2 basic layers: service and presentation.

Service Layer
=============

2 implementations of `IAccessService` have been provided. The use of Factory
pattern makes it easy to switch between a mock implementation and the real one.
Mock is used by default due to low update frequency of Tour do Flex data source.

The factory is defined in a top-level Parsley context, so that `IAccessService`
is available for injection in any child component.

Presentation Layer
==================

A generic `AccessDataDisplay` component is responsible for aggregating data
updates so as to minimise display list updates. The presentation of data is
delegated to its skin class. The component makes no assumptions as to how the
data will be presented. Concrete skin class is attached based on `styleName`.

The Link
========

`AccessData` tag is the link between the service and presentation layers. It
receives an instance of `IAccessService` and communicates updates to
`AccessDataDisplay`.

We can imagine having multiple display components all listening to updates from
a single service exposed via a data tag.

Review
======

The actual streaming service implementation has been written in the most
rudimentary manner, lacking error handling. In a real systems one would have to
consider making performance optimisations such as sharing channel sets between
multiple consumers, and sharing subscriptions between multiple clients.

Pie chart skin needs polish. Starting and stopping subscription is jerky.

Building The Project
====================

Built using Flex 4.6, Parsley 3.0, FlexUnit 4.1 and Flex Data Services.

Add the following folders to your source path: `src`, `resources`.

Add the following folders to your test source path: `test`.

`libs` contains the above mentioned libraries.
