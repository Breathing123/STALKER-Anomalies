local item = ScriptManager.instance:getItem("Anomalies.ArtifactDetector")
if item then 
    item:DoParam("DisplayCategory = Artifact Detector")
end

local item2 = ScriptManager.instance:getItem("Anomalies.Artifact")
if item2 then 
    item2:DoParam("DisplayCategory = Artifact")
end