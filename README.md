# Automated Preservation Recommendations
This repository contains a [Wiki](https://github.com/preservica/automated-preservation-recommendations/wiki) of information related to recommendation preservation actions in support of Preservica Automated-Preservation functionality, and will also serve some basic tools for working with PRONOM data.

## XSLT files

The 'pronom-signature-reconstructor.xsl' file is an XSLT routine that will transform a DROID binary signature XML file and output a list of PRONOM signatures that will match the entry on a given PRONOM file format page. There are some limitations:

* This has been targeted to work with XSLT version 1, to allow it to be executed with the MSXML library used by the Notepad++ XML Tools plugin. There are likely to be more efficient ways to achieve aspects of this tranformation with later XSLT versions, but the aim is to keep the bar of entry low, so please bear this in mind if suggesting optimisation.
* The manner in which individual signature sequences are presently rebuilt means that any signature that contains more than 15 separate leftFragments or more than 15 separate rightFragments (i.e. not either/or blocks, actual separate sequences) will not be fully reconstructed. This handles all official PRONOM binary signatures as of v108. Extending this is relatively trivial.
* PRONOM allows the syntax '??' to express: "This single byte can have any value." The reconstructor rebuilds these with the syntax '{1}', meaning "A wildcard sequence of exactly one byte," which will produce exactly the same outcome.
* Container signature XML files are not handled by the reconstructor.
