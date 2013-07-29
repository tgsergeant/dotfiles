#!/usr/bin/env python3
import sys, os, string, subprocess
import random, time

DOMAIN = "pic.timsergeant.com"

if __name__ == "__main__":
	picfile = sys.argv[1]
	randomID = "".join([random.choice(string.ascii_letters.join(string.digits)) for i in range(5)])

	subprocess.call("s3cmd put --acl-public --guess-mime-type {} s3://{}/{}.png".format(picfile, DOMAIN, randomID), shell=True)
	subprocess.call("echo \"http://{}/{}.png\" | xclip".format(DOMAIN, randomID), shell=True)
	subprocess.call("notify-send \"Screenshot captured\" \"http://{}/{}.png\"".format(DOMAIN, randomID), shell=True)
	subprocess.call("mv {} /media/data/Pictures/Screenshots/scrot/{}.png".format(picfile, randomID), shell=True)
