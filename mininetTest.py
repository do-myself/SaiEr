#!/usr/bin/python

from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSController
from mininet.node import CPULimitedHost, Host, Node
from mininet.node import OVSKernelSwitch, UserSwitch
from mininet.node import IVSSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import TCLink, Intf
from subprocess import call

def myNetwork():

    # net = Mininet( topo=None,
    #                build=False,
    #                ipBase='10.0.0.0/8')
    net = Mininet(topo=None,
                  build=False,
                  )
    info( '*** Adding controller\n' )
    c0=net.addController(name='c0',
                      controller=RemoteController,
                      ip='::1',
                      protocol='tcp',
                      port=6654)

    info( '*** Add switches\n')
    s2 = net.addSwitch('s2', cls=OVSKernelSwitch)
    s4 = net.addSwitch('s4', cls=OVSKernelSwitch, dpid='4')
    s3 = net.addSwitch('s3', cls=OVSKernelSwitch, dpid='3')
    s1 = net.addSwitch('s1', cls=OVSKernelSwitch)

    info( '*** Add hosts\n')
    h9 = net.addHost('h9', cls=Host, defaultRoute=None)
    h16 = net.addHost('h16', cls=Host,  defaultRoute=None)
    h11 = net.addHost('h11', cls=Host,  defaultRoute=None)
    h7 = net.addHost('h7', cls=Host,  defaultRoute=None)
    h14 = net.addHost('h14', cls=Host,  defaultRoute=None)
    h12 = net.addHost('h12', cls=Host, defaultRoute=None)
    h5 = net.addHost('h5', cls=Host,  defaultRoute=None)
    h10 = net.addHost('h10', cls=Host,  defaultRoute=None)
    h3 = net.addHost('h3', cls=Host, defaultRoute=None)
    h2 = net.addHost('h2', cls=Host,  defaultRoute=None)
    h1 = net.addHost('h1', cls=Host,  defaultRoute=None)
    h15 = net.addHost('h15', cls=Host,  defaultRoute=None)
    h6 = net.addHost('h6', cls=Host,defaultRoute=None)
    h8 = net.addHost('h8', cls=Host,  defaultRoute=None)
    h4 = net.addHost('h4', cls=Host, defaultRoute=None)
    h13 = net.addHost('h13', cls=Host,defaultRoute=None)

    info( '*** Add links\n')
    net.addLink(s1, s2)
    net.addLink(s2, s3)
    net.addLink(s3, s4)
    net.addLink(s1, h1)
    net.addLink(h2, s1)
    net.addLink(s1, h3)
    net.addLink(s1, h4)
    net.addLink(s2, h5)
    net.addLink(s2, h6)
    net.addLink(s2, h7)
    net.addLink(s2, h8)
    net.addLink(s3, h9)
    net.addLink(s3, h10)
    net.addLink(s3, h11)
    net.addLink(s3, h12)
    net.addLink(s4, h13)
    net.addLink(s4, h14)
    net.addLink(s4, h15)
    net.addLink(s4, h16)

    info( '*** Starting network\n')
    net.build()

    h1.cmd("ifconfig h1-eth0 inet6 add 2001:00:00:00:00:00:0a00:0001/112 up")
    h2.cmd("ifconfig h2-eth0 inet6 add 2001:00:00:00:00:00:0a00:0002/112 up")
    h3.cmd("ifconfig h3-eth0 inet6 add 2001:00:00:00:00:00:0a00:0003/112 up")
    h4.cmd("ifconfig h4-eth0 inet6 add 2001:00:00:00:00:00:0a00:0004/112 up")
    h5.cmd("ifconfig h5-eth0 inet6 add 2001:00:00:00:00:00:0a00:0005/112 up")
    h6.cmd("ifconfig h6-eth0 inet6 add 2001:00:00:00:00:00:0a00:0006/112 up")
    h7.cmd("ifconfig h7-eth0 inet6 add 2001:00:00:00:00:00:0a00:0007/112 up")
    h8.cmd("ifconfig h8-eth0 inet6 add 2001:00:00:00:00:00:0a00:0008/112 up")
    h9.cmd("ifconfig h9-eth0 inet6 add 2001:00:00:00:00:00:0a00:0009/112 up")
    h10.cmd("ifconfig h10-eth0 inet6 add 2001:00:00:00:00:00:0a00:000a/112 up")
    h11.cmd("ifconfig h11-eth0 inet6 add 2001:00:00:00:00:00:0a00:000b/112 up")
    h12.cmd("ifconfig h12-eth0 inet6 add 2001:00:00:00:00:00:0a00:000c/112 up")
    h13.cmd("ifconfig h13-eth0 inet6 add 2001:00:00:00:00:00:0a00:000d/112 up")
    h14.cmd("ifconfig h14-eth0 inet6 add 2001:00:00:00:00:00:0a00:000e/112 up")
    h15.cmd("ifconfig h15-eth0 inet6 add 2001:00:00:00:00:00:0a00:000f/112 up")
    h16.cmd("ifconfig h16-eth0 inet6 add 2001:00:00:00:00:00:0a00:0010/112 up")

    info( '*** Starting controllers\n')
    for controller in net.controllers:
        controller.start()

    info( '*** Starting switches\n')
    net.get('s2').start([c0])
    net.get('s4').start([c0])
    net.get('s3').start([c0])
    net.get('s1').start([c0])

    info( '*** Post configure switches and hosts\n')
    # s4.cmd('ifconfig s4 ::10.0.0.24')
    # s3.cmd('ifconfig s3 ::10.0.0.23')

    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    myNetwork()