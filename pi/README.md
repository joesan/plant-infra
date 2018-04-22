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

The above command will create an tmpty ssh file under the boot directory of your flashed SD card. This is vital for doing remote SSH login to your Pi.

REPEAT STEP 1 FOR ALL OF YOUR PI's

### STEP 2: Boot up & Configure the Pi

Insert the flashed SD card in the Pi and hook up the power source. The power source will be your AUKEY USB Power Source that you might have purchased. Assuming that you have a home router, connect the LAN cable of your home router to the LAN slot on the Pi. We will make the following changes to the Pi:

#### Log In To Your Raspberry Pi

For you to be able to ssh into your Pi, you have to identify what the IP address your home router has allocated to your Pi. You can do this by logging on to the homepage of your home router. It should be generally available at one of the following URL's:

http://192.168.0.1 or http://192.168.1.1

If prompted for a "Settings Password", you can find it from your ISP documentation or look for a sticker on your home router for the password. Once you log in, look for a link that says "All Connected Devices" or "Connected Devices". You should then be able to see your Raspberry Pi and get the IP address. Have a look at the screenshot below:

TODO: Add screenshot

#### Change the default password and the hostname

It is a good practice to change the default password of your Pi, which is raspberry. To change the default password, do the following:

Open a terminal windown on your local machine and ssh into your Pi with the ip address of your Pi:

```
$ ssh pi@192.168.0.122
```

Type the password and log in. Once logged in, give the following command to change the password:

```
$ raspbian.local:~ pi$ passwd
```

Now, by default your pi has raspbian.local as the host name. It makes sense to change this so that you can later on ssh into it with your hostname that you can identify and relate to. I would rename my Pi to something meaningful and contextful. In this case, I would name my Pi's as masters and workers. Since we are dealing with multiple masters and workers, I would assign each Pi, the corresponding name with a number associated with it. For example., if I have multiple masters, I would name them k8s-master-01, kas-master-02 and so on.

To set the hostname for your Pi, do the following:

```
sudo nano /etc/hostname
```

This file contains only one line - the name of your Pi.  Change the name to whatever you like, but only use the letters 'a' to 'z' (upper or lower), digits '0' to '9', and the dash '-'

Save the file using Ctrl+x, then Y followed by Enter

There is a second file that also contains the hostname. Therefore you should also edit that file:

```
sudo nano /etc/hosts
```

Find the line starting with 127.0.0.1, and change the name following it to your new hostname.  Save the file using Ctrl+x, then Y followed by Enter

#### Set a static IP for the Pi

It makes sense here to assign a static IP for your Pi, even though this is considered a bad practice in the networking world. But we want to make sure that the cluster does not break when you power off ynd on your set of Pi's. To set a static IP do the following:

From the ssh terminal window, give the following command:

```
sudo nano /etc/dhcpcd.conf
```

Copy and paste this block of settings in the dhcpcd.conf file:

```
profile static_eth0
static ip_address=192.168.0.100/24
static routers=192.168.0.1
static domain_name_servers=8.8.8.8
```
Make sure that you change the ip_address accordingly. Here in my case, I would just name them from 101 to 110. So my k8s-master-01 would be allocated to 192.168.0.101 and my k8s-master-02 would be allocated to 192.168.0.102 and so on

REPEAT STEP 2 FOR ALL OF YOUR PI's

### STEP 3: Set up K8s Master

### STEP 4: Set up K8s Worker
