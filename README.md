# decisionExpt_averaging
# Experiment investigating the effects of stimulus timing on evidence accumulation during the complex averaging of acoustic information (2016)
*Author: David Greatrex, University of Cambridge.  
*Date: 18/08/2016 -- Language: MATLAB. -- Modifications:

## Summary:
This package contains an original psychophysical decision-making experiment designed and run at the University of Cambridge. 

## Requirements:
MATLAB (MathWorks) - the program was build in version R2015b.
Psychtoolbox3 (http://psychtoolbox.org/) - version 3.0.13 - Flavor: beta - Corresponds to SVN Revision 8038.

## Installation and run:
Clone the respository to a local folder and set MATLABs current directory to the selected folder.
Enter 'averaging(X)' into the MATLAB terminal to start the experiment. 'X' should be the participant ID.
Response keys are vertically aligned '2' and '8' on the keypad of numerical keyboard.
Key to response mappings are defined during the on-screen instructions.

## Experimental overview:
The field of perceptual decision-making is dominated by the concept that simple classification judgements are the result of an accumulation-to-bound process. Noisy sensory evidence associated with choice alternatives is thought to accumulate towards a decision boundary and a decision is made when evidence in favour of one alternative exceeds this threshold (Gold & Shadlen 2007). A class of computational models based on this assumption, generally termed sequential sampling models (SSMs), have successfully described response time distributions and error rates across a wide range of perceptual decisions. They have also been proven to be neurobiologically plausible and have been used to model single-cell firing rates during perceptual choice. 

One key feature of SSMs is that choice outcome follows a termination rule which is organism and not environment dependent. The termination rule determines the threshold boundary at which evidence accumulation stops and a response is made. As a result, choices are often made before all of the available perceptual information concerning each alternative has been perceived. 
Whilst this constraint means that important information may be excluded from the decision process, it acts to reduce sampling cost and frees up cognitive resource. The brain must therefore strike a balance between the amount of information it collects and decision accuracy when setting the termination rule (Kiani et al, 2008, Forstmann et al, 2016}.

Many perceptual decision-making experiments force participants to listen or view stimuli with a fixed duration and then to respond during a determined response period. This method is problematic when collecting behaviorual data as it becomes impossible to dissociate decision processes from response processes and to know at what point in time participants would have gathered enough decision evidence before responding naturally. Hence, participants might make up their mind as to which category a stimulus belongs to well before they have perceived the entire stimulus and before the defined response period. The data, however, would not be able to show this.  

'decisionExpt_averaging' addresses the above limitation. It investigates the effects of temporal variance on complex decision-making in a scenario in which participants control the stimulus duration. As a result, the task is more representative of everyday decision-making than those that use a fixed response period and allows for the explicit analysis of the decision-making process.

## Questions being investigated:
1. Does temporal variance in a sequnece of acoustic events affect response time distributions and error rates in a self-paced complex averaging task?
2. If so, which components of the decision-making process are affected according to a drift-diffusion model (a widely used SSM)?

The experiment is designed so that participants' responses can be used to determine answer to the first question and the structure of the generated data used as input to a drift diffusion model.

## Task:
On each trial participants hear an acoustic sequence of up to 20 noise bursts. Each noise burst is spatially lateralized via interaural level differences (ILDs) and can sound anywhere from far left (-90 degrees azimuth) to far right (+90 degrees azimuth) on the horizontal plane. The array of ILD values on each trial is selected randomly from a Gaussian distribution of ILD values with either a positive or negative mean (i.e. either left or right of mid-point). Stimulus sampling ensures that the selected ILD array has the same statistical qualities (mean and variance) as the underlying spatial distribution.

The task is to decide as accurately and as fast as possible whether the mean of the underlying spatial distribution is located to the left or right of mid-point. This requires accumulating decision-information associated with each noise burst and inferring the average location of the noise burst distribution. The response is self paced and participants can respond as soon as they have an answer.
Importantly, this means that they are not required to listen to the entire sequence before responding. Corrective feedback is given after every response.

The mean location of the underlying ILD distribution is manipulated throughout the experiment using the psychophysical method of constant stimuli. Some trials are therefore easy to classify (due to the mean of the distribution being far away from mid-point), whereas others are harder to classify (due to the mean of the distribution being close to mid-point). The timing of the sequence is also manipulated and can either form a periodic rhythm (3 Hz - 333 ms) or an irregular aperiodic rhythm.

It is hypothesised, based on previous findings (Greatrex, 2015; 2016), that periodicity will decrease the time it takes for participants to respond (and thus the amount of sampled decision-information required to reach a decision), but not necessarily increase the accuracy of the decision. All sounds are digitally generated in Matlab (The MathWorks) at a sampling rate of 48.8 kHz and should be presented over professional grade headphones in a sound attenuated recording booth. 

## References
* [Brainard, D. H. (1997). The psychophysics toolbox. Spatial vision, 10, 433-436.](http://bbs.bioguider.com/images/upfile/2006-4/200641014348.pdf)
* [Gold, J. I. and Shadlen, M. N. (2007). The neural basis of decision making. Annu. Rev. Neurosci., 30:535–574.](http://www.annualreviews.org/doi/abs/10.1146/annurev.neuro.29.051605.113038)
* [Kiani, R., Hanks, T. D., and Shadlen, M. N. (2008). Bounded integration in parietal cortex underlies decisions even when viewing duration is dictated by the environment. The Journal of Neuroscience, 28(12):3017–3029.](http://www.jneurosci.org/content/28/12/3017.short)
* [Forstmann, B., Ratcliff, R., and Wagenmakers, E.-J. (2016). Sequential sampling models in cognitive neuroscience: Advantages, applications, and extensions. Psychology, 67(1):641.](http://www.annualreviews.org/eprint/2stAyEdsCkSk9MpsHMDV/full/10.1146/annurev-psych-122414-033645)
* Greatrex, D. (2015). The effect of temporal expectation on complex averaging decisions. PhD Thesis. University of Cambridge.
* Greatrex, D. (2016). Accounting for stimulus rate and complexity during complex decision-making. PhD Thesis. University of Cambridge.
* [The MathWorks](http://uk.mathworks.com/) 