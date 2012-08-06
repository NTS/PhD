# This is the Makefile
#
# It is run by the git-hook post-commit
# or manually by entering the directory in a shell and issuing the command
# 'make'

default:
	sh .scripts/process.sh
