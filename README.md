# Automated Preservation Recommendations
[The main purpose of the repository is the Recommendations Wiki](https://github.com/preservica/automated-preservation-recommendations/wiki) which provides detail related to recommendation preservation actions in support of Preservica Automated-Preservation functionality. 

The repo will also serve some basic tools that may be of use for those that wish to explore PRONOM's file format data, from which the recommendated file format re-identification actions have been derived.

## XSLT files

#### PRONOM Signature Reconstructor

The 'pronom-signature-reconstructor.xsl' file is an XSLT routine that will transform a DROID binary signature XML file and output a comma-separated list of all formats that have PRONOM signatures, and will reconstuct those signature is their original form, as given on their PRONOM file format page. There are some limitations:

* This has been targeted to work with XSLT version 1, to allow it to be executed with the MSXML library used by the Notepad++ XML Tools plugin. There are likely to be more efficient ways to achieve aspects of this tranformation with later XSLT versions, but the aim is to keep the bar of entry low, so please bear this in mind if suggesting optimisation.
* The manner in which individual signature sequences are presently rebuilt means that any signature that contains more than 15 separate leftFragments or more than 15 separate rightFragments (i.e. not either/or blocks, actual separate sequences) will not be fully reconstructed. This handles all official PRONOM binary signatures as of v108. Extending this is relatively trivial.
* PRONOM allows the syntax '??' to express: "This single byte can have any value." The reconstructor rebuilds these with the syntax '{1}', meaning "A wildcard sequence of exactly one byte," which will produce exactly the same outcome.
* Container signature XML files are not handled by the reconstructor.

#### PRONOM Formats List

'pronom-formats-list.xsl' is a simple XSLT routine that will transform a DROID binary signature XML file, and will output a comma-separated list of every PRONOM PUID, format name and format version in the file.

Note that Microsoft Excel has a habit of changing version numbers such as '1-9' into dates, which when can behave oddly when turned back into string or numeric values, so be mindful of this when working with the data.
