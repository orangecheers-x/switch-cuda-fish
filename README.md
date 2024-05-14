# switch-cuda-fish

在多版本cuda共存时, 这个fish script可以帮助切换环境变量中指定的cuda版本.

这个script时供fish shell用的, 在 https://github.com/phohenecker/switch-cuda 基础上修改. 原作者的script是为bash shell设计的, 我将其迁移到fish shell.

## Usage

``` fish
> source switchcuda.fish 12.4
Switched to CUDA 12.4.
```

``` fish
> source switchcuda.fish                                           (slora)
The following CUDA installations have been found (in '/usr/local'):
* cuda-11.8
* cuda-12.4
```