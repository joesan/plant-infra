# Kubernetes Cluster SetUp on a Raspberry Pi 

This is a multi step process and we go through each of this in this document

## Pre-Requisites

You need to set up your Pi's with the OS, the K8s cluster, connect the Pi's to the internet. But first of all you need the items that you are going to work with. Let us go over the shopping list!

## Shopping List

You need the following items to work with:

* Raspberry Pi (Either model 2 or model 3) - Get the model 3 B+ as it carries more power. I recommend getting atleast 4 of them.

* A stackable case to hold your Pi's - I got [this case](https://tinyurl.com/ycpe78u3) and a [holding plate](https://tinyurl.com/ycomf998) from Amazon Germany. The holding place for me is just a way for me to be able to stack more Pi's later on. You will find something similiar in your region. Search for "Stackable open Raspberry Pi cases" and I'm sure you will find something similiar to mine.

* 32 GB Micro SDHC cards - Get a class 10 than has a good read / write speed. I bought the [San Disk Ultra](https://tinyurl.com/y9fx6k6b) with 32 GB capacity.

* Power supply for the Pi's - The official power supply recommendation for the Pi 3 model B+ is a 5v and 2.5A - Take a look [here](https://www.raspberrypi.org/help/faqs/) and search for "WHAT ARE THE POWER REQUIREMENTS" on that page. So based on this, I would recommend to get the following:

  AUKEY 6 Port 60W USB Charger - Have a look [here](https://tinyurl.com/y9horcbv)

* You need micro USB cables to power up your pi

  AUKEY Micro USB Power Cable - Have a look [here](https://tinyurl.com/yabcnfq2)
  
* Category 6 Flat LAN cables (TODO: Add Documentation....)

I would prefer not to spend any more money on any additional accessories like a monitor or a USB keyboard. You can do this whole setup as headless. Please read on to find out how!

## Set Up Steps

Now that we have all the components that we need, it is time for us to get started with the set up!

### STEP 1: Download the Raspbian OS & Flash the SD Card

Head on to the [Raspbian Downloads](https://www.raspberrypi.org/downloads/raspbian/) and download the latest version of the software that is available. At the time of this writing, it is the April 2018 version that I used. Get the one with no UI packages in it. I downloaded the RASPBIAN STRETCH LITE. Once you download the zip file, you can either extract it or if you intend to use Etcher, you can leave it as is.

For flashing the SD card, you can download this awesome tool from resin.io, the "Etcher" - You can download it from [here](https://etcher.io/)

Once you download Etcher, the flashing process is pretty simple and straight forward. Just add the image, select the drive (Etcher even pre-selects the SD card for you. Just verify it for the correctness and hit Flash.

There is one very important step that you should do to enable SSH access to your Pi once you connect it to your router. On your Mac, after you have flashed your SD card, open a Terminal window and do the following:

```
$ touch /Volumes/boot/ssh
```

REPEAT STEP 1 FOR ALL OF YOUR PI's

### STEP 2: Boot up the Pi

Insert the flashed SD card in the Pi and hook up the power source. The power source will be your AUKEY USB Power Source that you might have purchased. Assuming that you have a home router, connect the LAN cable of your home router to the LAN slot on the Pi. We will make the following changes to the Pi:

#### Change the default hostname

Now, by default your pi has raspbian.local as the host name. It makes sense to change this so that you can later on ssh into it

REPEAT STEP 2 FOR ALL OF YOUR PI's

### STEP 3: Set up K8s Master

### STEP 4: Set up K8s Worker
