#!/bin/bash

# Build the slides
rym pack .

# Copy assets to package directory  
cp *.png package/ 2>/dev/null || true
cp *.mp4 package/ 2>/dev/null || true

# Add Open Graph meta tags to the HTML
sed -i.bak '/viewport/a\
    \
    <!-- Open Graph Meta Tags -->\
    <meta property="og:title" content="Workshop: Terminal for the Masses :: V01">\
    <meta property="og:description" content="These are the slides from the Workshop: Terminal for the Masses presented on September 9, 2025 at New Stadium, Toronto. Explores terminal literacy through interactivity, immediacy, and interoperability with live Nushell demos.">\
    <meta property="og:image" content="https://cablehead.github.io/terminal-for-the-masses-v01/og.png">\
    <meta property="og:url" content="https://cablehead.github.io/terminal-for-the-masses-v01/">\
    <meta property="og:type" content="website">\
    <meta property="og:site_name" content="Terminal for the Masses">\
    \
    <!-- Twitter Card Meta Tags -->\
    <meta name="twitter:card" content="summary_large_image">\
    <meta name="twitter:title" content="Workshop: Terminal for the Masses :: V01">\
    <meta name="twitter:description" content="These are the slides from the Workshop: Terminal for the Masses presented on September 9, 2025 at New Stadium, Toronto. Explores terminal literacy through interactivity, immediacy, and interoperability with live Nushell demos.">\
    <meta name="twitter:image" content="https://cablehead.github.io/terminal-for-the-masses-v01/og.png">\
' package/index.html

# Remove backup file
rm package/index.html.bak

# Commit and deploy
git add package
git commit -m "build slides"
git push
git push origin "$(git subtree split --prefix package main):refs/heads/gh-pages" --force