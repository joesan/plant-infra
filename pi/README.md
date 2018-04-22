# Kubernetes Cluster SetUp on a Raspberry Pi 

This is a multi step process and we go through each of this in this document

## Pre-Requisites

You need to set up your Pi's with the OS, the K8s cluster, connect the Pi's to the internet. But first of all you need the items that you are going to work with. Let us go over the shopping list!

## Shopping List

You need the following items to work with:

* Raspberry Pi (Either model 2 or model 3) - Get the model 3 B+ as it carries more power. I recommend getting atleast 4 of them.

* A stackable case to hold your Pi's - I got [this case](https://www.amazon.de/H%C3%B6henverstellbares-stapelbares-Abstandsbolzen-Vullers-Tech/dp/B00NB1WPEE/ref=sr_1_1?ie=UTF8&qid=1524379184&sr=8-1&keywords=H%C3%B6henverstellbares+stapelbares+Raspberry+Pi+3%2C+Raspberry+Pi+2%2C+Raspberry+Pi+B%2B+Geh%C3%A4use+Glasklar) and a [holding plate](https://www.amazon.de/Zwischenplatte-Raspberry-Vullers-Tech-G-RP-BPC/dp/B00NB1WQZW/ref=sr_1_1?s=computers&ie=UTF8&qid=1524379276&sr=1-1&keywords=x+Zwischenplatte+f%C3%BCr+Raspberry+Pi+3%2C+Raspberry+Pi+2%2C+Raspberry+Pi+B%2B%2C+A%2B%2C+Vullers+Tech+Case+G-RP-BPC) from Amazon Germany. The holding place for me is just a way for me to be able to stack more Pi's later on. You will find something similiar in your region. Search for "Stackable open Raspberry Pi cases" and I'm sure you will find something similiar to mine.

* 32 GB Micro SDHC cards - Get a class 10 than has a good read / write speed. I bought the [San Disk Ultra](https://www.amazon.de/SanDisk-Ultra-microSDHC-Speicherkarte-Adapter/dp/B073S8LQSL/ref=sr_1_fkmr0_2?ie=UTF8&qid=1524379123&sr=8-2-fkmr0&keywords=micro+sdhc+card+san+dick) with 32 GB capacity.

* Power supply for the Pi's - The official power supply recommendation for the Pi 3 model B+ is a 5v and 2.5A - Take a look [here](https://www.raspberrypi.org/help/faqs/) and search for "WHAT ARE THE POWER REQUIREMENTS" on that page. So based on this, I would recommend to get the following:

  AUKEY 6 Port 60W USB Charger - Have a look [here](https://www.amazon.de/dp/B01EH11AS8/ref=pe_3044161_185740101_TE_item)

* You need micro USB cables to power up your pi

  AUKEY Micro USB Power Cable - Have a look [here](https://www.amazon.de/AUKEY-Micro-USB-Kabel-St%C3%BCcke-  Schwarz/dp/B00XL8U4LS/ref=pd_bxgy_107_img_2?_encoding=UTF8&pd_rd_i=B00XL8U4LS&pd_rd_r=87e74f31-45f4-11e8-b420-fd7b38a6d1e8&pd_rd_w=Atx0J&pd_rd_wg=rLebh&pf_rd_i=desktop-dp-sims&pf_rd_m=A3JWKAKR8XB7XF&pf_rd_p=5721820101550835664&pf_rd_r=YMM7GN3BNW1MQXSGY3M4&pf_rd_s=desktop-dp-sims&pf_rd_t=40701&psc=1&refRID=YMM7GN3BNW1MQXSGY3M4)

I would prefer not to spend any more money on any additional accessories like a monitor or a USB keyboard. You can do this whole setup as headless. Please read on to find out how!

Now that we have all the components that we need, it is time for us to get started with the set up!

### STEP 1: Flash the SD Card

### STEP 2: Boot up the Pi

### STEP 3: Set up K8s Master

### STEP 4: Set up K8s Worker
