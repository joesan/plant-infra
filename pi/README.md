# Kubernetes Cluster SetUp on a Raspberry Pi 

This is a multi step process and we go through each of this in this document

## Pre-Requisites

You need to set up your Pi's with the OS, the K8s cluster, connect the Pi's to the internet. But first of all you need the items that you are going to work with. Let us go over the shopping list!

## Shopping List

Have a look [here](https://github.com/joesan/plant-infra/blob/master/pi/SHOPPING_LIST.md)

## Set Up Steps

Now that we have all the components that we need, it is time for us to get started with the set up! As always, for the impatient, here is how the final setup would look like:

![Final Setup 1](https://github.com/joesan/plant-infra/blob/master/pi/images/final_setup_1.JPG)

![Final Setup 2](https://github.com/joesan/plant-infra/blob/master/pi/images/final_setup_2.JPG)

### STEP 1: Download the Raspbian OS & Flash the SD Card

Head on to the [Raspbian Downloads](https://www.raspberrypi.org/downloads/raspbian/) and download the latest version of the software that is available. At the time of this writing, it is the April 2018 version that I used. Get the one with no UI packages in it. I downloaded the RASPBIAN STRETCH LITE. Once you download the zip file, you can either extract it or if you intend to use Etcher, you can leave it as is.

For flashing the SD card, you can download this awesome tool from resin.io, the "Etcher" - You can download it from [here](https://etcher.io/)

Once you download Etcher, the flashing process is pretty simple and straight forward. Just add the image, select the drive Etcher even pre-selects the SD card for you. Just verify it for the correctness of the selecetd drive and hit Flash.

![Etcher Flashing](https://github.com/joesan/plant-infra/blob/master/pi/images/Etcher.png)

There is one very important step that you should do to enable SSH access to your Pi once you connect it to your router. On your Mac, after you have flashed your SD card, open a Terminal window and run the following command:

```
$ touch /Volumes/boot/ssh
```

The above command will create an tmpty ssh file under the boot directory of your flashed SD card. This is essential for doing remote SSH login to your Pi.

REPEAT STEP 1 FOR ALL OF YOUR PI's

### STEP 2: Boot up & Configure the Pi

Insert the flashed SD card in the Pi and hook up the power source. The power source will be your AUKEY USB Power Source that you might have purchased. Assuming that you have a home router, connect the LAN cable of your home router to the LAN slot on the Pi. We will make the following changes to the Pi:

#### Log In To Your Raspberry Pi

For you to be able to ssh into your Pi, you have to identify what the IP address your home router has allocated to your Pi. You can do this by logging on to the homepage of your home router. It should be generally available at one of the following URL's:

http://192.168.0.1 or http://192.168.1.1

If prompted for a "Settings Password", you can find it from your ISP documentation or look for a sticker on your home router for the password. Once you log in, look for a link that says "All Connected Devices" or "Connected Devices". You should then be able to see your Raspberry Pi and get the IP address. For example., have a look at the screenshot below for the list of devices that are connected to my home network:

![Connected Devices](https://github.com/joesan/plant-infra/blob/master/pi/images/connected_devices.png)

#### Change the default password and the hostname

It is a good practice to change the default password of your Pi, which is raspberry. To change the default password, do the following:

Open a terminal windown on your local machine and ssh into your Pi with the ip address of your Pi:

```
$ ssh pi@192.168.0.227
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

Find the line starting with 127.0.0.1, and change the name following it to your new hostname.  Save the file using Ctrl+x, then Y followed by Enter.

Here after you can log in to your Pi using the hostname as:

```
ssh pi@k8s-master-01.local
```

Make sure you supply the .local to the hostname, otherwise it does not work!

#### Set a static IP for the Pi

It makes sense here to assign a static IP for your Pi, even though this is considered a bad practice in the networking world. But we want to make sure that the cluster does not break when you power on and off your set of Pi's. To set a static IP do the following:

From the ssh terminal window, give the following command:

```
sudo nano /etc/dhcpcd.conf
```

Copy and paste this block of settings in the dhcpcd.conf file:

```
profile static_eth0
static ip_address=192.168.0.101/24
static routers=192.168.0.1
static domain_name_servers=192.168.0.1
```
Make sure that you change the ip_address accordingly. Here in my case, I would just name them from 101 to 110. So my k8s-master-01 would be allocated to 192.168.0.101 and my k8s-master-02 would be allocated to 192.168.0.102 and so on! You might additionally add a rule in your routers DHCP server configuration and set this static ip address to the corresponding Mac address of the Pi. Consult your routers documentation on how to do this!

For my reference, here is how my IP addresses look like:

| | Device SSH Login Name |  Device SSH Login Password | Static IP Address |
| --- | --- |  --- |  --- |
| Master-01 | ssh@k8s-master-01.local | ???? | 192.168.0.101 |
| Worker-01 | ssh@k8s-worker-01.local | ???? | 192.168.0.106 |
| Worker-02 | ssh@k8s-worker-02.local | ???? | 192.168.0.107 |
| Worker-03 | ssh@k8s-worker-03.local | ???? | 192.168.0.108 |

#### Configure CGroup Memory

As a prerequisite, we need to configure cgroup memory!

We have to change also some settings connected with cgroups (which provide a mechanism for easily managing and monitoring system resources, by partitioning things like cpu time, system memory, disk and network bandwidth, into groups, then assigning tasks to those groups). Edit file /boot/cmdline.txt and add at the end following text:

```
sudo nano /boot/cmdline.txt
```

Add the following at the end of the file:

```
cgroup_enable=cpuset cgroup_memory=1
```

If that did not work, use the following setting:

```
cgroup_enable=memory cgroup_memory=1
```

Without this settings we will have troubles with initialization of Kubernetes master node.

Once you have done all the steps above, let us reboot the pi so that your settings could take effect. Just give the following command to reboot your Pi:

```
sudo reboot
```

When you log in the next time, you should be able to see the ip address that you have just configured for the Pi.

REPEAT STEP 2 FOR ALL OF YOUR PI's

### STEP 3: Install Docker and Kubernetes

Use the following command to install Docker:

```
curl -sSL get.docker.com | sh && \
  sudo usermod pi -aG docker
```

For Kubernetes 1.7 and newer you will get an error if swap space is enabled, so we need to disable swap:

```
sudo dphys-swapfile swapoff && \
  sudo dphys-swapfile uninstall && \
  sudo update-rc.d dphys-swapfile remove
```

To make sure that swap is removed or disabled, the following command should give no result or entries back:

```
$ sudo swapon --summary
```

Once Docker is installed and swap disabled, we can proceed with the installation of [kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/). Now if you are concerned about installting a specific version of the kubernetes cluster, you can try the following command that will give you all the available versions:

```
curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages | grep Version | awk '{print $2}'
```

You can now decide on the version that you want toinstall. As a side note, as of this writing, it is advisable to not go beyond 1.9.6 version of Kubernetes as the later versions have some bugs and is unstable at the moment.

```
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
  sudo apt-get update -q && \
  sudo apt-get install -qy kubelet=1.9.6-00 kubectl=1.9.6-00 kubeadm=1.9.6-00
```

We are now done with the needed installations, it is now time to set up our master!

REPEAT STEP 3 FOR ALL OF YOUR PI's

### STEP 4: Set up K8s Master

So we now have installed the kubeadm tool, we will use this to initialize our master node. To do this we first create a config file called kubeadm_config.yaml

```
$sudo nano kubeadm_conf.yaml
```

Add the following content to it:

```
apiVersion: kubeadm.k8s.io/v1alpha1
kind: MasterConfiguration
controllerManagerExtraArgs:
  pod-eviction-timeout: 40s
```

Next initialize the the kubeadm as follows:

```
$sudo kubeadm init --config kubeadm_conf.yaml
```

The above command will take some time to finish. Have a coffee break and be back! Once it is done, you will see the following lines towards the end of the console:

```
...
Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join --token 31f222.uiopf5b3b8765432 192.168.0.101:6443 --discovery-token-ca-cert-hash sha256:0817b62e3e9d4b1407db8653c71df87d70fc21a4331aad8czU87hgdgsh89Op0
```

Now, just follow the instructions from the output that you got!

```
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Now, let us verify if our master is up and running:

```
pi@k8s-master-01:~ $ kubectl get nodes
NAME            STATUS     ROLES     AGE       VERSION
k8s-master-01   NotReady   master    7m        v1.9.6
pi@k8s-master-01:~ $
```

Don’t mind the status being NotReady. In order for the master node to become ready we need to install a container network. Let us do that now!

#### Set up the container network

Nodes are not able to communicate without a container network, which is something you have to provide. Therefore, the final piece of the puzzle is to add one. We will be using weave-net for this. On the master node, run the following command:

```
$ kubectl apply -f https://git.io/weave-kube-1.6
```

#### HA Master SetUp
If you are aiming for a HA master / etcd setup, have a look at the following official documentation. It is a bit elaborated and a time consuming process to set up HA master / etcd. So good luck and if you manage to do it, please let me know!

https://kubernetes.io/docs/setup/independent/high-availability/#installing-prerequisites-on-masters

### STEP 5: Join K8s Worker

Having set up the master node, let us now see how we can set up the worker and eventually join it with the master!

So setting up the worker nodes is just a matter of joining it with a running master node. Here is how to do it. Just make sure to run this command as a root user!

```
sudo kubeadm join --token your token 192.168.0.101:6443 --discovery-token-ca-cert-hash your hash
```

Running the above command on my system gives me the following output:

```
[preflight] Running pre-flight checks.
	[WARNING SystemVerification]: docker version is greater than the most recently validated version. Docker version: 18.04.0-ce. Max validated version: 17.03
	[WARNING FileExisting-crictl]: crictl not found in system path
[discovery] Trying to connect to API Server "192.168.0.101:6443"
[discovery] Created cluster-info discovery client, requesting info from "https://192.168.0.101:6443"
[discovery] Requesting info from "https://192.168.0.101:6443" again to validate TLS against the pinned public key
[discovery] Cluster info signature and contents are valid and TLS certificate validates against pinned roots, will use API Server "192.168.0.101:6443"
[discovery] Successfully established connection with API Server "192.168.0.101:6443"

This node has joined the cluster:
* Certificate signing request was sent to master and a response
  was received.
* The Kubelet was informed of the new secure connection details.

Run 'kubectl get nodes' on the master to see this node join the cluster.
pi@k8s-worker-01:~ $
```

Repeat the join command on all the other worker nodes as well!

Happy Kuberneting!!!!
