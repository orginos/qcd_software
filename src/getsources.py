'''
Created on Oct 30, 2014

@author: bjoo
'''
from subprocess import call
import os


def gitGet(pkg_name, git_url, branch,tag=False):
    if tag == False:
        # its a real branch you can check it out
        command = ("git clone --recursive "+git_url+" -b "+branch).split()
        call(command)
    else:
        # its a tag, not a real branch:
        command = ("git clone --recursive "+git_url).split()
        call(command)
	cwd=os.getcwd();
	print "Changing dir to "+cwd+"/"+pkg_name
	os.chdir(cwd+"/"+pkg_name)
	print "Checking out tag "+branch
        command = ("git checkout "+branch).split()
        call(command)
	print "Changing back to "+cwd
 	os.chdir(cwd)


    
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
chroma = ("chroma", "GIT", "git@github.com:JeffersonLab/chroma.git","master",False)
qdpxx = ("qdpxx", "GIT", "git@github.com:usqcd-software/qdpxx.git", "master",False)
qdp_jit=("qdp-jit", "GIT", "git@github.com:fwinter/qdp-jit","master",False)
qmp=("qmp", "GIT", "git@github.com:usqcd-software/qmp.git", "master",False)
quda=("quda", "GIT", "git@github.com:lattice/quda.git", "master",False)
qphix=("qphix", "GIT", "git@github.com:JeffersonLab/qphix.git", "master",False)
#harom=("harom", "GIT", "git@github.com:JeffersonLab/harom.git", "master",False)
harom=("harom", "GIT", "git@github.com:JeffersonLab/harom.git", "devel",False)
hadron=("hadron", "GIT", "git@github.com:JeffersonLab/hadron.git", "master",False)
tensor=("tensor", "GIT", "git@github.com:JeffersonLab/tensor.git", "master",False)

# QDP/C libraries for Multigrid
qdpc=("qdp", "GIT", "git@github.com:usqcd-software/qdp.git", "qdp1-10-0",True)
qio=("qio", "GIT", "git@github.com:usqcd-software/qio.git", "qio2-3-9",True)
qla=("qla", "GIT", "git@github.com:usqcd-software/qla.git", "qla1-8-0",True)
qopqdp=("qopqdp", "GIT", "git@github.com:usqcd-software/qopqdp.git", "qopqdp0-19-3", True)

# These two pacakges are annoyying to get via GITHUB, so I have to package them  :(

libxml2=("libxml2", "TARGZ", "./libxml2.tar.gz", "libxml2",True)
mdwf=("mdwf", "TARGZ", "./mdwf-1.1.4.tar.gz", "mdwf-1.1.4",True)

# FULL PACKAGE LIST -- I distribute this because I have the 'ansidecl' thing commented out
package_list=[ chroma, qdpxx, harom, hadron, tensor, qdp_jit, qmp, mdwf, quda, qphix, qdpc, qio, qla, qopqdp, libxml2 ]

for pkg in package_list:
        (name,method,url,branchname,tagP)=pkg 
                 
        print "Getting Package "+name+" via "+method+" from "+url
        if method =="GIT" :
            gitGet(name,url,branchname,tagP)
        elif method == "WGET":   
            wgetGet(name,url,branchname)
        elif method == "CURL":
            curlGet(name,url,branchname)
	elif method == "TARGZ":
	    tarGet(name,url,branchname)

        print

            
