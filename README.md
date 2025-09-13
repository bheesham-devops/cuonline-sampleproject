# Maven Jenkins Project

This is a Maven project updated to work with Java 21 and modern Maven plugins.

## Changes Made

- Updated Java version from 1.7 to 11 for compatibility with Java 21
- Updated Maven compiler plugin to version 3.11.0
- Updated all Maven plugins to modern versions
- Moved reportPlugins configuration to proper reporting section
- Replaced deprecated prerequisites with maven-enforcer-plugin
- Updated Jetty plugin to modern Eclipse Jetty version

## Building

```bash
mvn clean package
```

## Running

```bash
mvn jetty:run
```
