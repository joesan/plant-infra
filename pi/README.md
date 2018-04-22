# Kubernetes Cluster SetUp on a Raspberry Pi 

This is a multi step process and we go through each of this in this document

## Pre-Requisites

You need to set up your Pi's with the OS, the K8s cluster, connect the Pi's to the internet. But first of all you need the items that you are going to work with. Let us go over the shopping list!

## Shopping List

You need the following items to work with:

* Raspberry Pi (Either model 2 or model 3) - Get the model 3 B+ as it carries more power. I recommend getting atleast 4 of them.

* A stackable case to hold your Pi's - I got [this case](https://www.amazon.de/dp/B00NB1WPEE/ref=pe_3044161_185740101_TE_item) and a [holding plate](https://www.amazon.de/dp/B00NB1WQZW/ref=pe_3044161_185740101_TE_item) from Amazon Germany. You will find something similiar in your region. Search for "Stackable open Raspberry Pi cases" and I'm sure you will find something similiar to mine.

* Power supply for the Pi's - The official power supply recommendation for the Pi 3 model B+ is a 5v and 2.5A - Take a look [here](https://www.raspberrypi.org/help/faqs/) and search for "WHAT ARE THE POWER REQUIREMENTS" on that page. So based on this, I would recommend to get the following:

AUKEY 6 Port 60W USB Charger - Have a look [here](https://www.amazon.de/dp/B01EH11AS8/ref=pe_3044161_185740101_TE_item)

* You need micro USB cables to power up your pi

AUKEY Micro USB Power Cable - Have a look [here](https://www.amazon.de/AUKEY-Micro-USB-Kabel-St%C3%BCcke-Schwarz/dp/B00XL8U4LS/ref=pd_bxgy_107_img_2?_encoding=UTF8&pd_rd_i=B00XL8U4LS&pd_rd_r=87e74f31-45f4-11e8-b420-fd7b38a6d1e8&pd_rd_w=Atx0J&pd_rd_wg=rLebh&pf_rd_i=desktop-dp-sims&pf_rd_m=A3JWKAKR8XB7XF&pf_rd_p=5721820101550835664&pf_rd_r=YMM7GN3BNW1MQXSGY3M4&pf_rd_s=desktop-dp-sims&pf_rd_t=40701&psc=1&refRID=YMM7GN3BNW1MQXSGY3M4)
