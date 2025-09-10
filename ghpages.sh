#!/bin/bash

# Build the slides
rym pack .

# Copy assets to package directory  
cp *.png package/ 2>/dev/null || true
cp *.mp4 package/ 2>/dev/null || true

# Commit and deploy
git add package
git commit -m "build slides"
git push
git push origin "$(git subtree split --prefix package main):refs/heads/gh-pages" --force