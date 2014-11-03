'''
Created on Oct 30, 2014

@author: bjoo
'''
from subprocess import call
import os


def gitGet(pkg_name, git_url, branch):
    command = ("git clone --recursive "+git_url+" -b "+branch).split()
    call(command)
    
    
def wgetGet(pkg_name, wget_url, releasename):
    zipname=releasename+".tar.gz"
    command1=("wget "+wget_url).split()
    command2=("tar zxf "+zipname).split()
    command3=("mv "+releasename+" "+pkg_name).split()

    call(command1)
    call(command2)
    call(command3)
    
def curlGet(pkg_name, curl_url, zipname):
    command1=("curl "+curl_url+" > "+zipname).split()
    print "Our working dir is " + os.getcwd()
    command2=("tar zxf "+zipname).split()
    command3=("mv "+zipname+" "+pkg_name).split()
    call(command1)
    call(command2)
    call(command3)
    
def tarGet(pkg_name, tar_file, untar_name):
    command=("tar zxf "+tar_file).split();
    call(command)
 
# QDP++ and Chroma
chroma = ("chroma", "GIT", "git@github.com:JeffersonLab/chroma.git","master")
qdpxx = ("qdpxx", "GIT", "git@github.com:usqcd-software/qdpxx.git", "master")
qdp_jit=("qdp-jit", "GIT", "git@github.com:fwinter/qdp-jit","master")
qmp=("qmp", "GIT", "git@github.com:usqcd-software/qmp.git", "master")
quda=("quda", "GIT", "git@github.com:lattice/quda.git", "quda-0.7")
qphix=("qphix", "GIT", "git@github.com:JeffersonLab/qphix.git", "master")

# QDP/C libraries for Multigrid
qdpc=("qdp", "GIT", "git@github.com:usqcd-software/qdp.git", "qdp1-10-0")
qio=("qio", "GIT", "git@github.com:usqcd-software/qio.git", "qio2-3-9")
qla=("qla", "GIT", "git@github.com:usqcd-software/qla.git", "qla1-8-0")
qopqdp=("qopqdp", "GIT", "git@github.com:usqcd-software/qopqdp.git", "qopqdp0-19-3")

# These two pacakges are annoyying to get via GITHUB, so I have to package them  :(

libxml2=("libxml2", "TARGZ", "./libxml2.tar.gz", "libxml2")
mdwf=("mdwf", "TARGZ", "./mdwf-1.1.4.tar.gz", "mdwf-1.1.4")

# FULL PACKAGE LIST -- I distribute this because I have the 'ansidecl' thing commented out
package_list=[ chroma, qdpxx, qdp_jit, qmp, mdwf, quda, qphix, qdpc, qio, qla, qopqdp, libxml2 ]


for pkg in package_list:
        (name,method,url,branchname)=pkg 
                 
        print "Getting Package "+name+" via "+method+" from "+url
        if method =="GIT" :
            gitGet(name,url,branchname)
        elif method == "WGET":   
            wgetGet(name,url,branchname)
        elif method == "CURL":
            curlGet(name,url,branchname)
	elif method == "TARGZ":
	    tarGet(name,url,branchname)

        print

            
