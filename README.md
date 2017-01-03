# FaultTree.SCRAM
Interaction between FaultTree on R and SCRAM

**SCRAM** is a **C**ommand-line **R**isk **A**nalysis **M**ulti-tool.

[SCRAM](http://scram-pra.org) is a free and open source probabilistic risk analysis tool
that supports the [Open-PSA](http://open-psa.org)
[Model Exchange Format](https://open-psa.github.io/mef).
SCRAM is licensed under the GPLv3.

It is desired to find means by which the FaultTree package on R can leverage
the advanced calculations of SCRAM. Currently, SCRAM is most accessable on
the Ubuntu Linux distribution (Version 14.04 or higher). Initial interaction will
take the form of independent operation of both packages on a common Linux
instance. For Windows users this is expected to be enabled by a Virtual Machine.
Instructions for such a setup for those who have never done so is provided
at www.openreliability.org

SCRAM takes its input in the form of the opsa-mef (Model Exchange Format) in
an XML file. So the first function in the FaultTree.SCRAM package is a conversion
from the ftree object to the mef format. This function is ftree2mef.

The file will be written with the following name `[object_name]_mef.xml`

This is then loaded into SCRAM for MOCUS calculation with a terminal command:

```bash
scram [object_name]_mef.xml --mocus -o [object_name]_scram_mocus.xml
```

Since this file is not yet quite useful in R another parser function will
be required in this FaultTree.SCRAM package.
