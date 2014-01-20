---

layout: post
title: "Restoring Archived Files from Amazon Glacier"
description: "This script can be used to restore Amazon S3 objects that were archived using the lifecycle feature of Amazon S3."

---

###The Problem

A few weeks ago I got into a situation in which I needed to restore a large number of files from Amazon's then-new service: S3 Archive (Glacier). These objects (Amazon's word for files), are not standard Glacier objects, but are S3 objects that have been [transitioned](http://docs.amazonwebservices.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html) to long-term storage. You can read more about Glacier [here](http://aws.amazon.com/glacier/).

######The Other Problem

Normally you could restore these objects in the AWS console, but being a new service, Amazon didn't consider the use case of restoring files in bulk across the multiple directories presented in the AWS console. Yes, I know S3 doesn't have directories, they only have objects. However, the objects are presented as if they were folders in the AWS management console. Every slash is translated into a directory that can be traversed and scrolled though. You can scroll though directories using their awkward, slow web interface that the returns to the top of the listing every time you navigate in and out of a folder, making the prospect of restoring these files a multi-month proposition. This meant that the console was out of the question. So that meant writing a script using the Amazon Web Services API.

###The Solution

I had two options for writing a script to restore these objects: 

1. Use the Java SDK provided by Amazon
2. Write something myself since the Amazon Ruby SDKs are out of date and the existing Ruby libraries had not yet been updated to work with S3 archived object and don't offer you a way to make an arbitrary POST request (that I could tell).

So I set out to use the standard S3 API v2 (which I was using in the app I was working on) to restore these objects using a signed POST request to `object_name?restore` to the specified object. Below is that script I cranked out during a sleepless state of delirium.

###Usage:

Make a file called `files_to_restore.txt` in the same directory as the `glacier_restore.rb` file shown in the gist below.
Add your files in the format (one object per line, no leading slash, no bucket name):

    sub/folder/object_1.ext
    another/sub/folder/object_2.ext

run:

    ruby glacier_restore.rb > out.txt 2>err.txt

or, to resume a stopped job:

    ruby glacier_restore.rb >> out.txt 2>>err.txt

###tl;dr

This script can be used to restore Amazon S3 objects that were archived using the [lifecycle](http://docs.amazonwebservices.com/AmazonS3/latest/UG/LifecycleConfiguration.html) feature of Amazon S3. 

###Disclaimer

This is an ugly piece of code that I found useful for a short period of time. Hence I do not intend to maintain this script. I share it only in the hopes that restoring files from S3 archive is less painful for you than it was for me. I used this script to restore tens of thousands of objects before Amazon was able to step in and take over with a script that they had written themselves. Best of luck!

###License

Copyright © 2012 Sascha Winter

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

---

###Further Reading:

See the [RESTObjectPOSTrestore](http://docs.amazonwebservices.com/AmazonS3/latest/API/RESTObjectPOSTrestore.html) and [restoring-objects](http://docs.amazonwebservices.com/AmazonS3/latest/dev/restoring-objects.html) for more info.

<script src="https://gist.github.com/4092579.js"></script>
