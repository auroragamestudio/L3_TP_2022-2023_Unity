using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class LinkSkyAndSun : MonoBehaviour
{
    public Material skyboxMaterial;
    private Light _light;
    
    // Start is called before the first frame update
    void Start()
    {
        _light = GetComponent<Light>();
    }

    // Update is called once per frame
    void Update()
    {
        if( _light != null )
            skyboxMaterial.SetFloat("_Exposure", _light.intensity);
    }
}
